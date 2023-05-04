import '../network/error_handler.dart';
import '../response/responses.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_HOME_INTERVAL = 60 * 1000;
const CACHE_STORE_DETAILS_KEY = 'CACHE_STORE_DETAILS_KEY';
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeRespons> getHomeData();

  Future<void> saveHomeToCache(HomeRespons homeRespons);

  void clearCache();

  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails(HomeRespons homeRespons);

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeRespons> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is nor there or it's not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeRespons homeRespons) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeRespons);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails(HomeRespons homeRespons) async {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null) {
      cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL);
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(response) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItenExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMills = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMills - cacheTime <= expirationTimeInMillis;
    // exirationTimeInMillis -> 60 sec
    // currentTimeInMills -> 1:00:00
    // cacheTime -> 12:59:30
    // valid untill 1:00:30
    return isValid;
  }
}
