// @ts-nocheck
export const defs = {};
export const deps = {};
defs["ErrorLog"] = function define($) {
  const __Base = $.Object;
  class __ErrorLog extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static sendLog(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = new ($.C("flash.net.URLVariables"))();
         _loc4_["level"] = 5000;
         _loc4_["text"] = "UserId:" + param1 + "  " + param2;
         _loc4_["ran"] = Math.random();
         var _loc7_ = $.str( param3.REQUEST_PATH["@value"] + "logReuest");
         var _loc5_ = new ($.C("flash.net.URLRequest"))(_loc7_);
         var _loc6_ = new ($.C("flash.net.URLLoader"))();
         _loc6_.data = _loc4_;
         _loc6_.dataFormat = "text";
         _loc6_.load(_loc5_);
      }
  }
  $.meta(__ErrorLog, "ErrorLog", []);
  return __ErrorLog;
}
deps["ErrorLog"] = ["flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables"];

defs["Loading"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __Loading extends __Base {
    static $fields(self) {
    self._config = null;
    self._configURL = "config.xml";
    self._configLoader = null;
    self._flashSite = "";
    self._requestPath = null;
    self._user = "";
    self._pass = "";
    self._userInfo = null;
    self._site = "";
    self._p2 = "";
    self._rid = "";
    self._loginType = "1";
    self._tip = null;
    self._textFormat = null;
    self._showRegisterLoading = false;
    self._queueView = null;
    }
    constructor() {
         super();
         if(this.stage)
         {
            this.init();
         }
         else
         {
            this.addEventListener("addedToStage",$.bind(this, "init"));
         }
      }
    init() {
         $.C("com.greensock.plugins.TweenPlugin").activate([$.C("com.greensock.plugins.TransformAroundCenterPlugin")]);
         $.C("com.greensock.plugins.TweenPlugin").activate([$.C("com.greensock.plugins.MotionBlurPlugin")]);
         this.removeEventListener("addedToStage",$.bind(this, "init"));
         $.C("manager.ExternalInterfaceManager").instance.isSafeFlash();
         this.stage.align = "TL";
         this.stage.scaleMode = "noScale";
         this.stage.addEventListener("resize",$.bind(this, "__stageResizeHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").setup(this.stage);
         $.C("com.pickgliss.ui.LayerManager").Instance.setup(this.stage);
         $.C("manager.ExternalInterfaceManager").instance.setup();
         $.C("manager.ExternalInterfaceManager").instance.setSelfAdapting();
         $.C("manager.DesktopManager").Instance.checkIsDesktop();
         this._tip = new ($.C("flash.text.TextField"))();
         this._textFormat = new ($.C("flash.text.TextFormat"))("Arial",18,16769414,true,null,null,null,null,"center");
         this._tip.defaultTextFormat = this._textFormat;
         this._tip.autoSize = "center";
         this._tip.mouseEnabled = false;
         this._tip.text = "";
         this._tip.width = 1000;
         this._userInfo = {};
         if(this.stage.loaderInfo.parameters["user"])
         {
            this._user = this.stage.loaderInfo.parameters["user"];
         }
         if(this.stage.loaderInfo.parameters["key"])
         {
            this._pass = this.stage.loaderInfo.parameters["key"];
         }
         if(this.stage.loaderInfo.parameters["site"])
         {
            this._site = this.stage.loaderInfo.parameters["site"];
         }
         if(this.stage.loaderInfo.parameters["p2"])
         {
            this._p2 = this.stage.loaderInfo.parameters["p2"];
         }
         if(this.stage.loaderInfo.parameters["logintype"])
         {
            this._loginType = this.stage.loaderInfo.parameters["logintype"];
         }
         if(this._loginType != "1" && this._loginType != "2" && this._loginType != "3" && this._loginType != "4")
         {
            this._loginType = "1";
         }
         if(this._loginType == "2")
         {
            $.C("manager.DesktopManager").Instance.desktopType = 2;
         }
         if(this._loginType == "4")
         {
            $.C("manager.DesktopManager").Instance.desktopType = 4;
         }
         if(this.stage.loaderInfo.parameters["config"] && String(this.stage.loaderInfo.parameters["config"]).length > 1)
         {
            this._configURL = this.stage.loaderInfo.parameters["config"];
         }
         if(this.stage.loaderInfo.parameters["rid"])
         {
            this._rid = this.stage.loaderInfo.parameters["rid"];
         }
         if(this.stage.loaderInfo.parameters["http"])
         {
            if(this.stage.loaderInfo.parameters["http"] == "https:")
            {
               $.C("com.pickgliss.ui.ComponentSetting").ISFROMHTTPS = true;
            }
            else
            {
               $.C("com.pickgliss.ui.ComponentSetting").ISFROMHTTPS = false;
            }
         }
         this._userInfo.site = this._site;
         this._userInfo.user = this._user;
         this._userInfo.password = this._pass;
         this._userInfo.userId = 0;
         this._userInfo.site = this._site;
         this._userInfo.p2 = this._p2;
         this._userInfo.rid = this._rid;
         this._userInfo.tempPassword = String($.int(Math.random() * 10000000));
         this._userInfo.key = $.C("com.pickgliss.utils.MD5").hash(this._userInfo.tempPassword);
         this.loadConfig();
      }
    loadConfig() {
         var _loc1_ = new ($.C("flash.system.LoaderContext"))(false,$.C("flash.system.ApplicationDomain").currentDomain);
         $.C("com.pickgliss.loader.DisplayLoader").Context = _loc1_;
         $.C("com.pickgliss.utils.ClassUtils").uiSourceDomain = $.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain;
         $.C("com.pickgliss.loader.LoaderSavingManager").setup();
         this._configLoader = new ($.C("flash.net.URLLoader"))();
         this._configLoader.addEventListener("complete",$.bind(this, "__configLoadComplete"));
         this._configLoader.load(new ($.C("flash.net.URLRequest"))(this._configURL + "?rnd=" + Math.random().toString()));
      }
    __configLoadComplete(param1) {
         this._configLoader.removeEventListener("complete",$.bind(this, "__configLoadComplete"));
         this._configLoader = null;
         this.addChild(this._tip);
         this._tip.x = (this.stage.stageWidth - this._tip.width) / 2;
         this._tip.y = (this.stage.stageHeight - this._tip.height) / 2;
         var _loc5_ = new $.XML(param1.target.data);
         if($.C("com.pickgliss.ui.ComponentSetting").ISFROMHTTPS)
         {
            this.configConvertToHTTPS(_loc5_);
         }
         if(_loc5_.$descendants("config").length() > 0)
         {
            this._config = _loc5_.$descendants("config")[0];
            var _loc2_ = this._config.$descendants("NODE").$filter((__x) => (__x["@site"] == this._site));
            var _loc4_ = $.str( _loc2_.CLIENT_LOGIN_NAME["@value"]);
            var _loc3_ = $.str( this._config[0].VERSION["@value"]);
            $.C("manager.ExternalInterfaceManager").instance.setExternalInfo(_loc4_,_loc3_);
            this._requestPath = $.str( String(this._config[0].REQUEST_PATH["@value"]));
            this._flashSite = $.str( String(_loc2_.SITE["@value"]));
            $.C("com.pickgliss.ui.ComponentSetting").REQUEST_PATH = this._config[0].REQUEST_PATH["@value"];
            $.C("com.pickgliss.ui.ComponentSetting").TEMPLATE_PATH = this._config[0].TEMPLATE_PATH["@value"];
            $.C("com.pickgliss.ui.ComponentSetting").VERTION_PATH = $.C("com.pickgliss.ui.ComponentSetting").TEMPLATE_PATH + "version.xml";
            $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH = String(this._config[0].ResourcePath["@value"]);
            $.C("com.pickgliss.ui.ComponentSetting").BACKUP_RESOURCE_PATH = String(this._config[0].Backup_ResourcePath["@value"]);
            $.C("com.pickgliss.ui.ComponentSetting").LANGUAGE = String(this._config[0].LANGUAGE["@value"]);
            $.C("com.pickgliss.ui.ComponentSetting").SITE = String(this._userInfo.site);
            $.C("com.pickgliss.ui.ComponentSetting").LOGIN_RND = Math.random() * 10000;
            $.C("com.pickgliss.ui.ComponentSetting").initWorkedResourcePath();
            $.C("com.pickgliss.loader.DisplayLoader").isDebug = false;
            $.C("com.pickgliss.loader.DisplayLoader").isOldres = false;
            $.C("loading.MaxLoading").loadingSusliks = true;
            $.C("loading.MaxLoading").showNetTips = true;
            if(!this.setRSAKey())
            {
               return;
            }
            this.loadSelectList(null);
            return;
         }
         throw new ($.C("flash.events.ErrorEvent"))("SELECTLIST_LOAD_ERROR",true,false,"Load config file fail! Please try again later!");
      }
    configConvertToHTTPS(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc5_ = null;
         var _loc7_ = null;
         var _loc4_ = 0;
         var _loc6_ = param1.children();
         _loc4_ = 0;
         for(; _loc4_ < _loc6_.length(); _loc4_++)
         {
            _loc2_ = $.as(_loc6_[_loc4_], "XML");
            _loc3_ = $.str( _loc2_["@root"]);
            if(_loc3_ != null && _loc3_ != "")
            {
               _loc3_ = _loc3_.replace("http","https").replace(":8080","");
               _loc2_["@root"] = _loc3_;
            }
            _loc5_ = $.str( _loc2_["@source"]);
            if(_loc5_ != null && _loc5_ != "")
            {
               _loc5_ = _loc5_.replace("http","https").replace(":8080","");
               _loc2_["@source"] = _loc5_;
            }
            _loc7_ = $.str( _loc2_["@value"]);
            if(_loc7_ != null && _loc7_ != "")
            {
               if(_loc2_.name().localName == "UPLOAD_PATH")
               {
                  continue;
               }
               _loc7_ = _loc7_.replace("http","https").replace(":8080","");
               _loc2_["@value"] = _loc7_;
            }
            if(_loc2_.hasComplexContent())
            {
               this.configConvertToHTTPS(_loc2_);
            }
         }
      }
    setRSAKey() {
         var _loc2_ = null;
         var _loc3_ = null;
         for (var _loc1_ of $.values(this._config.$descendants("NODE")))
         {
            if(_loc1_["@site"] == this._site)
            {
               _loc2_ = $.str( _loc1_.RSAKey["@PublicKeyModulus"]);
               _loc3_ = $.str( _loc1_.RSAKey["@publicExponent"]);
               this._userInfo.RSAkey = $.C("utils.CrytoUtils").generateRsaKey(_loc2_,_loc3_);
               return true;
            }
         }
         this._tip.text = "Site não encontrado:" + this._site + " Retorno à página de login em 3 segundos";
         $.C("flash.utils.setTimeout")($.bind(this, "returnHome"),3000);
         return false;
      }
    returnHome() {
         if(this._site.indexOf("brazil") != -1 || this._site.indexOf("broas") != -1 || this._site.indexOf("337pt") != -1 || this._site.indexOf("pt") != -1)
         {
            if($.C("flash.external.ExternalInterface").available)
            {
               $.C("flash.external.ExternalInterface").call("callInterruption",this._user,this._site);
            }
            return;
         }
         $.C("manager.ExternalInterfaceManager").instance.returnHome();
         $.C("flash.net.navigateToURL")(new ($.C("flash.net.URLRequest"))(this._flashSite),"_self");
      }
    loadSelectList(param1) {
         var _loc3_ = new ($.C("flash.net.URLVariables"))();
         _loc3_["username"] = this._user;
         _loc3_["site"] = this._site;
         _loc3_["rnd"] = Math.random();
         var _loc2_ = new ($.C("flash.net.URLRequest"))(this._requestPath + "loginselectlist");
         _loc2_.data = _loc3_;
         var _loc4_ = new ($.C("flash.net.URLLoader"))();
         _loc4_.addEventListener("complete",$.bind(this, "__loadSelectListComplete"));
         _loc4_.addEventListener("ioError",$.bind(this, "__loadSelectListError"));
         _loc4_.load(_loc2_);
      }
    __loadSelectListError(param1) {
         throw new ($.C("flash.events.ErrorEvent"))("SELECTLIST_LOAD_ERROR",true,false,"Load selectList fail! Please try again later!");
      }
    __loadSelectListComplete(param1) {
         param1.target.removeEventListener("complete",$.bind(this, "__loadSelectListComplete"));
         param1.target.removeEventListener("ioError",$.bind(this, "__loadSelectListError"));
         var _loc2_ = $.XML(param1.target.data).$descendants("Item");
         if(_loc2_.length() > 0)
         {
            if(_loc2_[0]["@Active"] == "true")
            {
               this._userInfo.isActive = true;
            }
            this._userInfo.userId = $.int(_loc2_[0]["@ID"]);
         }
         this._userInfo.canJumpNovie = true;
         this.loadLogin();
      }
    register() {
         var _loc2_ = null;
         var _loc1_ = new ($.C("flash.net.URLVariables"))();
         _loc1_["client"] = $.C("manager.DesktopManager").Instance.isDesktop;
         _loc1_["userid"] = this._userInfo.userId;
         _loc1_["nickname"] = "";
         _loc1_["camp"] = "";
         _loc1_["icon"] = 100;
         _loc1_["username"] = this._userInfo.user;
         _loc1_["site"] = this._userInfo.site;
         _loc1_["key"] = this._userInfo.key;
         _loc1_["ran"] = Math.random();
         if(this._p2 == "" || this._p2 == null || this._p2 + "" == "undefined")
         {
            _loc2_ = $.str( String(this._config.REQUEST_PATH["@value"]) + "visualizeregister");
         }
         else
         {
            _loc2_ = $.str( String(this._config.REQUEST_PATH["@value"]) + "visualizeregister2");
         }
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,7,8,$.bind(this, "__onRegisterCompleteHandler"),null,null,null,_loc1_);
      }
    __onRegisterCompleteHandler(param1, param2) {
         $.C("manager.ExternalInterfaceManager").instance.setFirstLeave(this._site,this._user);
         this.reqNoviceProcess();
      }
    loadLogin() {
         var _loc3_ = null;
         var _loc5_ = new ($.C("flash.net.URLVariables"))();
         var _loc4_ = new ($.C("flash.utils.ByteArray"))();
         var _loc6_ = this.myUrlEncode(this._user,"UTF-8");
         _loc4_.writeUTFBytes(_loc6_ + "|" + this._pass + "|" + this._userInfo.tempPassword + "|" + this._userInfo.userId);
         var _loc1_ = $.C("utils.CrytoUtils").rsaEncry4(this._userInfo.RSAkey,_loc4_);
         if($.C("manager.DesktopManager").Instance.isDesktop)
         {
            this._loginType = "2";
         }
         _loc5_["p"] = _loc1_;
         _loc5_["site"] = this._site;
         _loc5_["p2"] = this._p2;
         _loc5_["loginType"] = this._loginType;
         _loc5_["client"] = $.C("manager.DesktopManager").Instance.isDesktop;
         if(this._p2 == "" || this._p2 == null || this._p2 + "" == "undefined")
         {
            _loc3_ = this._requestPath + "login";
         }
         else
         {
            _loc3_ = this._requestPath + "login2";
         }
         var _loc2_ = new ($.C("queue.LoginQueue"))(_loc3_,_loc5_);
         _loc2_.backCall = $.bind(this, "__onLoginComplete");
         _loc2_.errorCall = $.bind(this, "showError");
         _loc2_.load();
      }
    myUrlEncode(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = 0;
         var _loc5_ = "";
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         _loc3_.writeMultiByte(param1,param2);
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc5_;
      }
    __onLoginComplete(param1) {
         if(this._queueView)
         {
            this._queueView.dispose();
            this._queueView = null;
         }
         var _loc3_ = $.str( param1["@Address"]);
         this._userInfo.userId = param1["@userId"];
         this._userInfo.serverName = param1["@CurrentServerName"];
         this._config.$descendants("SocktPath")["@value"] = _loc3_;
         this._config.$descendants("SocktPath")["@SocketPort"] = param1["@Port"];
         $.C("flash.system.Security").allowDomain("*");
         var _loc2_ = "xmlsocket://" + _loc3_ + ":843";
         $.C("flash.system.Security").loadPolicyFile(_loc2_);
         $.C("loading.SmallLoading").Instance.show(true);
         new ($.C("Md5Versions"))($.bind(this, "checkLunch"),$.bind(this, "onMD5LoadProgress"));
      }
    checkLunch() {
         var _loc1_ = null;
         if(!this._userInfo.isActive)
         {
            this._userInfo["noviceProcess"] = 0;
            $.C("LoginPreload").setup(this._config,this._userInfo);
            _loc1_ = new ($.C("RegisterLuncher"))();
            _loc1_.lunch(this._config,this._userInfo,this.stage);
         }
         else
         {
            this.reqNoviceProcess();
         }
      }
    reqNoviceProcess() {
         var _loc1_ = new ($.C("flash.net.URLLoader"))();
         var _loc2_ = new ($.C("flash.net.URLRequest"))();
         var _loc3_ = new ($.C("flash.net.URLVariables"))();
         _loc3_["op"] = 0;
         _loc3_["userid"] = this._userInfo.userId;
         _loc3_["noviceprocess"] = 0;
         _loc3_["key"] = this._userInfo.key;
         _loc3_["rnd"] = Math.random();
         _loc2_.url = this._requestPath + "updateplayernovice";
         _loc2_.data = _loc3_;
         _loc2_.method = "POST";
         _loc1_.addEventListener("complete",$.bind(this, "__noviceReqCompleteHandler"));
         _loc1_.load(_loc2_);
      }
    __noviceReqCompleteHandler(param1) {
         var _loc3_ = $.as(param1.currentTarget, $.C("flash.net.URLLoader"));
         _loc3_.removeEventListener("complete",$.bind(this, "__noviceReqCompleteHandler"));
         this._userInfo["noviceProcess"] = $.int(_loc3_.data);
         var _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("mainloading");
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,3,8,$.bind(this, "onNormalUILoadComplete"),$.bind(this, "onNormalUILoadProgress"));
      }
    onNormalUILoadComplete(param1, param2) {
         var _loc3_ = new ($.C("flash.net.URLVariables"))();
         _loc3_["rnd"] = $.C("com.pickgliss.ui.ComponentSetting").LOGIN_RND;
         var _loc4_ = $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + "background.jpg";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc4_,2,8,$.bind(this, "onloadingBgCompleteHandler"),$.bind(this, "onloadingBgProgress"),null,null,_loc3_);
      }
    lunchNormal(param1) {
         var _loc2_ = $.C("loading.MaxLoading").Instance;
         _loc2_.addBgToMc(param1);
         _loc2_.show(this.stage);
         var _loc3_ = new ($.C("NormalLuncher"))();
         _loc3_.lunch(this._config,this._userInfo,this.stage,_loc2_);
      }
    onloadingBgCompleteHandler(param1, param2) {
         var _loc3_ = {};
         _loc3_.url = "asset.loading.MainLoadingBg";
         if(param2)
         {
            _loc3_.bg = $.as(param2, $.C("flash.display.Bitmap"));
         }
         else
         {
            _loc3_.bg = null;
         }
         $.C("loading.SmallLoading").Instance.exit($.bind(this, "lunchNormal"),_loc3_);
      }
    onloadingBgProgress(param1) {
         var _loc2_ = param1.bytesLoaded / param1.bytesTotal;
         $.C("loading.SmallLoading").Instance.progress = 80 + _loc2_ * 20;
      }
    onMD5LoadProgress(param1) {
         var _loc2_ = param1.bytesLoaded / param1.bytesTotal;
         $.C("loading.SmallLoading").Instance.progress = _loc2_ * 50;
      }
    onNormalUILoadProgress(param1) {
         var _loc2_ = param1.bytesLoaded / param1.bytesTotal;
         $.C("loading.SmallLoading").Instance.progress = 50 + _loc2_ * 30;
      }
    showError(param1, param2 = 0, param3 = 0, param4 = 0, param5 = 0) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         var _loc6_ = $.C("LoginResultValue").getTipMessageByType(param1);
         if(param2 == 0)
         {
            _loc6_ += " Retorno à página de login em 3 segundos";
            $.C("flash.utils.setTimeout")($.bind(this, "returnHome"),3000);
         }
         else if(param2 == 1)
         {
            if(!this._queueView)
            {
               this._queueView = new ($.C("queue.LoginQueueView"))(this.stage);
            }
            this._queueView.update(param3,param4,param5);
            return;
         }
         $.trace(_loc6_);
         this._tip.text = _loc6_;
      }
    __stageResizeHandler(param1) {
         if(this._tip)
         {
            this._tip.x = (this.stage.stageWidth - this._tip.width) / 2;
            this._tip.y = (this.stage.stageHeight - this._tip.height) / 2;
         }
      }
    createLogin() {
      }
  }
  $.meta(__Loading, "Loading", []);
  return __Loading;
}
deps["Loading"] = ["LoginPreload", "LoginResultValue", "Md5Versions", "NormalLuncher", "RegisterLuncher", "com.greensock.plugins.MotionBlurPlugin", "com.greensock.plugins.TransformAroundCenterPlugin", "com.greensock.plugins.TweenPlugin", "com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.LoaderSavingManager", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ClassUtils", "com.pickgliss.utils.MD5", "flash.display.Bitmap", "flash.display.Sprite", "flash.events.ErrorEvent", "flash.external.ExternalInterface", "flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables", "flash.net.navigateToURL", "flash.system.ApplicationDomain", "flash.system.LoaderContext", "flash.system.Security", "flash.text.TextField", "flash.text.TextFormat", "flash.utils.ByteArray", "flash.utils.setTimeout", "loading.MaxLoading", "loading.SmallLoading", "manager.DesktopManager", "manager.ExternalInterfaceManager", "queue.LoginQueue", "queue.LoginQueueView", "utils.CrytoUtils"];

defs["LoginPreload"] = function define($) {
  const __Base = $.Object;
  class __LoginPreload extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static setup(param1, param2) {
         __LoginPreload._config = param1;
         __LoginPreload._userInfo = param2;
      }
    static load(param1 = true) {
         if(param1)
         {
            new ($.C("Md5Versions"))(__LoginPreload.loadFromRegister);
         }
         else
         {
            new ($.C("Md5Versions"))(__LoginPreload.loadFromNormal);
         }
      }
    static loadFromRegister() {
         if(__LoginPreload._regLoadIsStarted)
         {
            return;
         }
         __LoginPreload._regLoadIsStarted = true;
         var _loc1_ = new ($.C("flash.utils.Dictionary"))(true);
         _loc1_[$.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("mainloadingii")] = 3;
         _loc1_[$.C("com.pickgliss.ui.ComponentSetting").ZhanPath] = 5;
         _loc1_[$.C("com.pickgliss.ui.ComponentSetting").AgentZhanPath] = 7;
         if($.C("com.pickgliss.loader.DisplayLoader").isDebug)
         {
            _loc1_[$.C("com.pickgliss.ui.ComponentSetting").LanguagePath] = 7;
         }
         else
         {
            _loc1_[$.C("com.pickgliss.ui.ComponentSetting").LanguagePath] = 5;
         }
         __LoginPreload.loadResources(_loc1_,__LoginPreload.onRegLoadComplete);
      }
    static onRegLoadComplete() {
         __LoginPreload._regLoadIsCompleted = true;
         __LoginPreload.loadFromNormal();
      }
    static loadFromNormal() {
         if(__LoginPreload._norLoadIsStarted)
         {
            return;
         }
         __LoginPreload._norLoadIsStarted = true;
         var _loc1_ = new ($.C("flash.utils.Dictionary"))(true);
         _loc1_[$.C("com.pickgliss.ui.ComponentSetting").getUIConfigZIPPath()] = 1;
         _loc1_[$.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("2.png")] = 3;
         __LoginPreload.loadResources(_loc1_,__LoginPreload.onNorLoadComplete,8);
      }
    static onNorLoadComplete() {
         var _loc1_ = $.as($.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain.getDefinition("yishi.lunch.ConfigParaser"), "Class");
         if(!_loc1_.isInit)
         {
            _loc1_.paras(__LoginPreload._config,$.C("com.pickgliss.toplevel.StageReferance").stage.loaderInfo);
         }
         var _loc2_ = $.as($.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain.getDefinition("yishi.lunch.StartupResourcesLoader"), "Class");
         _loc2_.instance.addEventListener("coreUILoadComplete",__LoginPreload.__startupResourcesLoadComplete);
         _loc2_.instance.start(__LoginPreload._userInfo,__LoginPreload._config,true);
      }
    static __startupResourcesLoadComplete(param1) {
         if(param1 && param1.currentTarget)
         {
            param1.currentTarget.removeEventListener("coreUILoadComplete",__LoginPreload.__startupResourcesLoadComplete);
         }
         __LoginPreload._norLoadIsCompleted = true;
         __LoginPreload.loadOthers();
      }
    static loadOthers() {
         if(__LoginPreload._otherLoadIsStarted)
         {
            return;
         }
         __LoginPreload._otherLoadIsStarted = true;
         var _loc2_ = $.as($.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain.getDefinition("yishi.datas.UIModuleTypes"), "Class");
         var _loc1_ = new ($.C("flash.utils.Dictionary"))(true);
         __LoginPreload.loadResources(_loc1_,__LoginPreload.onOtherLoadComplete);
      }
    static onOtherLoadComplete() {
         __LoginPreload._otherLoadIsCompleted = true;
         __LoginPreload.dispose();
      }
    static loadResources(param1, param2 = null, param3 = 1) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         __LoginPreload._onListLoadComplete = param2;
         __LoginPreload._curLoadCount = 0;
         __LoginPreload._needLoadCount = __LoginPreload.getDicKeyNum(param1);
         if(__LoginPreload._needLoadCount <= 0)
         {
            if(__LoginPreload._onListLoadComplete != null)
            {
               __LoginPreload._onListLoadComplete();
            }
            return;
         }
         var _loc5_ = new ($.C("flash.net.URLVariables"))();
         _loc5_["rnd"] = $.C("com.pickgliss.ui.ComponentSetting").LOGIN_RND;
         for(var _loc4_ in param1)
         {
            switch(param1[_loc4_])
            {
               case 5:
               case 8:
               case 7:
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc4_,param1[_loc4_],param3,__LoginPreload.onSingleLoadComplete,null,null,null,_loc5_);
                  break;
               default:
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc4_,param1[_loc4_],param3,__LoginPreload.onSingleLoadComplete,null);
            }
         }
      }
    static onSingleLoadComplete(param1, param2) {
         __LoginPreload._curLoadCount = __LoginPreload._curLoadCount + 1;
         if(__LoginPreload._curLoadCount >= __LoginPreload._needLoadCount)
         {
            if(__LoginPreload._onListLoadComplete != null)
            {
               __LoginPreload._onListLoadComplete();
            }
         }
      }
    static getDicKeyNum(param1) {
         var _loc2_ = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
    static dispose() {
         __LoginPreload._config = null;
         __LoginPreload._userInfo = null;
         __LoginPreload._onListLoadComplete = null;
      }
  }
  $.meta(__LoginPreload, "LoginPreload", []);
  $.statics(__LoginPreload, () => {
    __LoginPreload._config = null;
    __LoginPreload._userInfo = null;
    __LoginPreload._regLoadIsStarted = false;
    __LoginPreload._regLoadIsCompleted = false;
    __LoginPreload._norLoadIsStarted = false;
    __LoginPreload._norLoadIsCompleted = false;
    __LoginPreload._otherLoadIsStarted = false;
    __LoginPreload._otherLoadIsCompleted = false;
    __LoginPreload._onListLoadComplete = null;
    __LoginPreload._curLoadCount = 0;
    __LoginPreload._needLoadCount = 0;
  });
  return __LoginPreload;
}
deps["LoginPreload"] = ["Md5Versions", "com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentSetting", "flash.net.URLVariables", "flash.utils.Dictionary"];

defs["LoginResultValue"] = function define($) {
  const __Base = $.Object;
  class __LoginResultValue extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static getTipMessageByType(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = null;
         switch(param1)
         {
            case "Parameter P Data Error":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Parameter Site Data Error":
               _loc2_ = "Erro de Parametro de Site";
               break;
            case "Login Invalidation":
               _loc2_ = "Falha do Login";
               break;
            case "Data Update Error":
               _loc2_ = "Servidor está ocupado";
               break;
            case "User IS Forbid":
               _loc2_ = "O usuário actual foi bloqueado";
               break;
            case "Login Failed":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Login Succeed No Visualize":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Login Max":
               _loc2_ = "Os usuários estão online já atingiu o máximo";
               break;
            case "Login Enter Is Close":
               _loc2_ = "Entrada de Log está fechada";
               break;
            case "Login Succeed":
               _loc2_ = "Login";
               break;
            case "Client Exception":
               _loc2_ = "Detectou anormalidades de Cliente, por favor login após 2 Min.";
               break;
            case "Client Plug Exception":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 30 Min.";
               break;
            case "Ip Is Forbid ":
               _loc2_ = "O IP atual foi proibido";
               break;
            case "Check Code Failed 2":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 5 Min. Caso falhe,começará 15 Min de deteção.";
               break;
            case "Check Code Failed 3":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 15 Min. Caso falhe,começará 30 Min de deteção.";
               break;
            case "Check Code Failed 4":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 30 Min. ";
               break;
            default:
               _loc2_ = param1;
         }
         return _loc2_;
      }
  }
  $.meta(__LoginResultValue, "LoginResultValue", []);
  $.statics(__LoginResultValue, () => {
    __LoginResultValue.LOGIN_FAILED = "Login Failed";
    __LoginResultValue.USER_IS_FORBID = "User IS Forbid";
    __LoginResultValue.LOGIN_SUCCEED = "Login Succeed";
    __LoginResultValue.DATA_UPDATE_ERROR = "Data Update Error";
    __LoginResultValue.LOGIN_INVALIDATION = "Login Invalidation";
    __LoginResultValue.PARAMETER_P_DATA_ERROR = "Parameter P Data Error";
    __LoginResultValue.PARAMETER_SITE_DATA_ERROR = "Parameter Site Data Error";
    __LoginResultValue.LOGIN_SUCCEED_NO_VISUALIZE = "Login Succeed No Visualize";
    __LoginResultValue.LOGIN_CLOSE = "Login Enter Is Close";
    __LoginResultValue.LOGINWAITE_MAX = "Login Max";
    __LoginResultValue.CLIENT_EXCEPTION = "Client Exception";
    __LoginResultValue.CLIENT_EXCEPTION2 = "Client Plug Exception";
    __LoginResultValue.P_FILTER = "Ip Is Forbid ";
    __LoginResultValue.CHECK_CODE_FAIL_1 = "Check Code Failed 1";
    __LoginResultValue.CHECK_CODE_FAIL_2 = "Check Code Failed 2";
    __LoginResultValue.CHECK_CODE_FAIL_3 = "Check Code Failed 3";
    __LoginResultValue.CHECK_CODE_FAIL_4 = "Check Code Failed 4";
  });
  return __LoginResultValue;
}
deps["LoginResultValue"] = [];

defs["Md5Versions"] = function define($) {
  const __Base = $.Object;
  class __Md5Versions extends __Base {
    static $fields(self) {
    self._md5Complete = null;
    self._codeComplete = null;
    self._resComplete = null;
    self._md5Progress = null;
    self._codeProgress = null;
    self._resProgress = null;
    self._versionXml = null;
    self._checkXml = null;
    self._versionLen = 0;
    self._checkLen = 0;
    self._enterFrame = 0;
    self._count = 100;
    self._currCount = 0;
    self._maxTime = 40;
    self._sprite = null;
    }
    constructor(param1, param2 = null) {
         super();
         this._md5Complete = param1;
         this._md5Progress = param2;
         this.loadCode($.bind(this, "md5CodeComplete"),this._md5Progress);
      }
    md5CodeComplete() {
         this.loadRes(this._md5Complete,this._md5Progress);
      }
    enterFrame(param1) {
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc2_ = false;
         var _loc5_ = $.C("flash.utils.getTimer")();
         var _loc6_ = /[\\]/g;
         _loc4_ = 0;
         while(_loc4_ < 100)
         {
            if(this._currCount > this._versionLen)
            {
               break;
            }
            _loc2_ = this.checkVersion(_loc5_,this._currCount,this._currCount + this._count);
            this._currCount += this._count;
            if(_loc2_)
            {
               return;
            }
            _loc4_++;
         }
         if(this._currCount < this._versionLen)
         {
            return;
         }
         if(this._sprite)
         {
            this._sprite.removeEventListener("enterFrame",$.bind(this, "enterFrame"));
         }
         if(this._resComplete != null)
         {
            this._resComplete();
         }
      }
    checkVersion(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc9_ = null;
         var _loc7_ = 0;
         var _loc5_ = $.C("flash.utils.getTimer")();
         var _loc8_ = /[\\]/g;
         if(param3 > this._versionLen)
         {
            param3 = this._versionLen;
         }
         _loc7_ = param2;
         while(_loc7_ < param3)
         {
            _loc4_ = this._versionXml[_loc7_];
            _loc6_ = $.str( $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + String(_loc4_["@name"]));
            _loc6_ = _loc6_.replace(_loc8_,"/");
            _loc9_ = new ($.C("com.pickgliss.ui.vo.FileVo"))();
            _loc9_.md5 = _loc4_["@md5"];
            _loc9_.size = _loc4_["@size"];
            $.C("com.pickgliss.ui.ComponentSetting").md5Dic[_loc6_] = _loc9_;
            _loc7_++;
         }
         return $.C("flash.utils.getTimer")() - param1 >= this._maxTime;
      }
    loadCode(param1, param2 = null) {
         this._codeComplete = param1;
         this._codeProgress = param2;
         var _loc5_ = new Date().time.toString();
         var _loc3_ = "code_md5.dat";
         if($.C("com.pickgliss.loader.DisplayLoader").isDebug)
         {
            _loc3_ = "md5.zip";
         }
         var _loc4_ = new ($.C("flash.net.URLVariables"))();
         _loc4_["rnd"] = _loc5_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc3_,1,8,$.bind(this, "__codemd5XmlLoadComplete"),$.bind(this, "__codemd5XmlLoadProgressHandler"),null,null,_loc4_);
      }
    loadRes(param1, param2 = null) {
         this._resComplete = param1;
         this._resProgress = param2;
         var _loc3_ = new Date().time.toString();
         var _loc4_ = "res_md5.dat";
         if($.C("com.pickgliss.loader.DisplayLoader").isOldres)
         {
            _loc4_ = "md5.zip";
         }
         var _loc5_ = new ($.C("flash.net.URLVariables"))();
         _loc5_["rnd"] = _loc3_;
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc4_,1,8,$.bind(this, "__md5XmlLoadComplete"),$.bind(this, "__md5XmlLoadProgressHandler"),null,null,_loc5_);
      }
    __codemd5XmlLoadComplete(param1, param2) {
         var _loc7_ = null;
         var _loc9_ = null;
         var _loc3_ = $.as(param2, $.C("flash.utils.ByteArray"));
         if(_loc3_)
         {
            _loc3_.uncompress();
            _loc3_.uncompress();
            _loc3_.position = 0;
         }
         var _loc8_ = /[\\]/g;
         var _loc4_ = new $.XML(_loc3_);
         var _loc6_ = _loc4_.$descendants("version").$descendants("Item");
         for (var _loc5_ of $.values(_loc6_))
         {
            _loc7_ = $.str( $.C("com.pickgliss.loader.DisplayLoader").isDebug ? String(_loc5_["@name"]) : $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + String(_loc5_["@name"]));
            _loc7_ = _loc7_.replace(_loc8_,"/");
            _loc9_ = new ($.C("com.pickgliss.ui.vo.FileVo"))();
            _loc9_.md5 = _loc5_["@md5"];
            _loc9_.size = _loc5_["@size"];
            $.C("com.pickgliss.ui.ComponentSetting").md5Dic[_loc7_] = _loc9_;
         }
         if(this._codeComplete != null)
         {
            this._codeComplete();
         }
      }
    __md5XmlLoadComplete(param1, param2) {
         var _loc3_ = $.as(param2, $.C("flash.utils.ByteArray"));
         if(_loc3_)
         {
            _loc3_.uncompress();
            _loc3_.uncompress();
            _loc3_.position = 0;
         }
         var _loc4_ = new $.XML(_loc3_);
         this._versionXml = _loc4_.$descendants("version").$descendants("Item");
         this._checkXml = _loc4_.$descendants("check").$descendants("Item");
         this._versionLen = this._versionXml.length();
         this._checkLen = this._checkXml.length();
         this._sprite = new ($.C("flash.display.Sprite"))();
         this._sprite.addEventListener("enterFrame",$.bind(this, "enterFrame"));
      }
    __codemd5XmlLoadProgressHandler(param1) {
         if(this._codeProgress != null)
         {
            this._codeProgress(param1);
         }
         if(this._md5Progress != null)
         {
            this._md5Progress(param1);
         }
      }
    __md5XmlLoadProgressHandler(param1) {
         if(this._resProgress != null)
         {
            this._resProgress(param1);
         }
         if(this._md5Progress != null)
         {
            this._md5Progress(param1);
         }
      }
  }
  $.meta(__Md5Versions, "Md5Versions", []);
  return __Md5Versions;
}
deps["Md5Versions"] = ["com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.vo.FileVo", "flash.display.Sprite", "flash.net.URLVariables", "flash.utils.ByteArray", "flash.utils.getTimer"];

defs["NormalLuncher"] = function define($) {
  const __Base = $.Object;
  class __NormalLuncher extends __Base {
    static $fields(self) {
    self._stage = null;
    self._maxLoading = null;
    self._moduleLoad = null;
    self._config = null;
    self._userInfo = null;
    self._callback = null;
    self._timeId = 0;
    self._stepCount = 16;
    self._count = 0;
    self._count2 = 0;
    self._loaderSavingCloseList = [21];
    self._startupLoader = undefined;
    self._proObj = null;
    self._preTotalPro = NaN;
    self._preSubPro = NaN;
    self._preSubProName = null;
    self._preStep = 0;
    self._prePro = 0;
    self._preTime = 0;
    self._isOpenWeb = false;
    }
    constructor() {
         super();
      }
    lunch(param1, param2, param3, param4, param5 = null) {
         this._config = param1;
         this._userInfo = param2;
         this._callback = param5;
         this._stage = param3;
         this._maxLoading = param4;
         this.checkLoaderSaving();
         this.start();
      }
    checkLoaderSaving() {
         var _loc2_ = $.C("flash.system.Capabilities").version.split(" ")[1];
         var _loc3_ = _loc2_.split(",");
         var _loc1_ = $.int(_loc3_[0]);
         if(this._loaderSavingCloseList.indexOf(_loc1_) == -1)
         {
            $.C("com.pickgliss.loader.LoaderSavingManager").OPEN_SHARED = true;
         }
         else
         {
            $.C("com.pickgliss.loader.LoaderSavingManager").OPEN_SHARED = false;
         }
      }
    start() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("2.png");
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,8,$.bind(this, "__loadeCompleteHandler"),$.bind(this, "__moduleProgressHandler"));
      }
    __moduleProgressHandler(param1) {
         var _loc3_ = param1.bytesLoaded / param1.bytesTotal;
         var _loc2_ = "Carregando    " + $.C("com.pickgliss.ui.ComponentSetting").getMD5FileNameByFilePath(param1.url);
         this.updateProgress(_loc3_ * 6 / 16 * 100);
         this._maxLoading["setItemLoaderInfo"](_loc3_,_loc2_);
      }
    updateProgress(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this.timeRefresh(param1);
         this._maxLoading["setProgress"](this.checkNumber(param1));
      }
    __loadeCompleteHandler(param1, param2) {
         var _loc3_ = $.C("com.pickgliss.ui.ComponentSetting").getUIConfigZIPPath();
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc3_,1,8,$.bind(this, "onLoadZipComplete"),$.bind(this, "onLoadZipProgress"));
      }
    onLoadZipProgress(param1) {
         var _loc3_ = param1.bytesLoaded / param1.bytesTotal;
         var _loc2_ = "Carregando    " + $.C("com.pickgliss.ui.ComponentSetting").getMD5FileNameByFilePath(param1.url);
         this.updateProgress(37.5 + 0.0625 * _loc3_ * 100);
         this._maxLoading["setItemLoaderInfo"](_loc3_,_loc2_);
      }
    onLoadZipComplete(param1, param2) {
         var _loc3_ = null;
         var _loc4_ = $.C("com.pickgliss.ui.ComponentSetting").getUrlMd5(param1.url);
         if($.C("com.pickgliss.ui.ComponentSetting").checkNeedAnalyzeMd5(_loc4_))
         {
            if($.C("com.pickgliss.ui.ComponentSetting").compareMD5($.as(param2, $.C("flash.utils.ByteArray")),_loc4_))
            {
               _loc3_ = new ($.C("flash.utils.ByteArray"))();
               param2.position = 37;
               param2.readBytes(_loc3_);
               this.unzipFile($.as(_loc3_, $.C("flash.utils.ByteArray")));
            }
         }
         else
         {
            this.unzipFile($.as(param2, $.C("flash.utils.ByteArray")));
         }
      }
    unzipFile(param1) {
         var _loc8_ = null;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc10_ = null;
         var _loc7_ = undefined;
         var _loc11_ = undefined;
         var _loc2_ = null;
         var _loc3_ = 0;
         param1.uncompress();
         _loc10_ = param1;
         _loc10_.position = 0;
         var _loc9_ = new ($.C("flash.utils.ByteArray"))();
         var _loc6_ = {};
         while(_loc10_.position != _loc10_.length)
         {
            _loc3_ = _loc10_.readByte();
            _loc8_ = _loc10_.readMultiByte(_loc3_,"utf-8");
            _loc4_ = _loc10_.readUnsignedInt();
            _loc9_.writeBytes(_loc10_,_loc10_.position,_loc4_);
            _loc10_.position += _loc4_;
            _loc9_.position = 0;
            _loc5_ = new $.XML(_loc9_);
            $.C("com.pickgliss.ui.ComponentFactory").Instance.setup(_loc5_);
            _loc9_.length = 0;
         }
         try
         {
            _loc7_ = $.as($.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain.getDefinition("yishi.lunch.Yishi"), "Class");
            this._startupLoader = $.C("com.pickgliss.loader.DisplayLoader").Context.applicationDomain.getDefinition("yishi.lunch.StartupResourcesLoader");
            this._startupLoader.instance.addEventListener("coreSetupLoadComplete",$.bind(this, "__startupCompleteHandler"));
            this._stage.addEventListener("enterFrame",$.bind(this, "__enterFrameHandler"));
            _loc11_ = new _loc7_();
            _loc11_.lunch(this._config,this._userInfo);
         }
         catch(e)
         {
            $.C("ErrorLog").sendLog(this._userInfo.userId,"解析核心库异常，重新请求2.png",this._config);
            $.C("com.pickgliss.loader.LoaderSavingManager").clearFiles($.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("2.png"));
            _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("2.png");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,3,8,$.bind(this, "__loadeCompleteHandler"),$.bind(this, "__moduleProgressHandler"));
         }
         _loc9_.clear();
         _loc9_ = null;
      }
    __startupCompleteHandler(param1) {
         this._stage.removeEventListener("enterFrame",$.bind(this, "__enterFrameHandler"));
         this._maxLoading["hide"]();
         this._proObj = null;
         this._stage = null;
         this._maxLoading = null;
         this._moduleLoad = null;
         this._config = null;
         this._userInfo = null;
         if(this._callback != null)
         {
            this._callback();
            this._callback = null;
         }
      }
    __enterFrameHandler(param1) {
         this._proObj = this._startupLoader.instance.proObj;
         var _loc3_ = Number(this._startupLoader.instance.templateProgress());
         var _loc2_ = $.int(this._startupLoader.instance.step);
         if(_loc3_ > 0)
         {
            this._maxLoading["setProgress"](75 + _loc3_);
         }
         else if(_loc2_ == 5)
         {
            this._maxLoading["setProgress"](99);
         }
         else if(_loc2_ < 5)
         {
            this.timeRefresh(this._proObj["totalPro"]);
            if(this._proObj["totalPro"] != this._preTotalPro)
            {
               this._preTotalPro = this._proObj["totalPro"];
               this._maxLoading["setProgress"](43.75 + this.checkNumber(this._preTotalPro));
            }
         }
         if(this._proObj["subPro"] != this._preSubPro || this._proObj["subProName"] != this._preSubProName)
         {
            this._preSubPro = this._proObj["subPro"];
            this._preSubProName = this._proObj["subProName"];
            this._maxLoading["setItemLoaderInfo"](this._preSubPro,this._preSubProName);
         }
      }
    checkNumber(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         param1 = $.int(param1 <= 0 ? 1 : param1);
         return $.int(param1 >= 100 ? 99 : param1);
      }
    timeRefresh(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(this._isOpenWeb)
         {
            return;
         }
         if(param1 == this._prePro)
         {
            _loc2_ = $.C("flash.utils.getTimer")();
            if(_loc2_ - this._preTime > 30000)
            {
               this._isOpenWeb = true;
               $.C("manager.ExternalInterfaceManager").instance.refreshWebSite();
            }
         }
         else
         {
            this._preTime = $.C("flash.utils.getTimer")();
         }
         this._prePro = param1;
      }
  }
  $.meta(__NormalLuncher, "NormalLuncher", []);
  $.statics(__NormalLuncher, () => {
    __NormalLuncher.UIMODULE_NAME = "mainloading";
    __NormalLuncher.CORE_CODE = "2.png";
    __NormalLuncher.YISHI_CLASS_PATH = "yishi.lunch.Yishi";
    __NormalLuncher.CONFIG_PARSER_CLASS = "yishi.lunch.ConfigParaser";
    __NormalLuncher.STARTUP_LOADER_CLASS = "yishi.lunch.StartupResourcesLoader";
    __NormalLuncher.UIMODULE_TYPES_CLASS = "yishi.datas.UIModuleTypes";
  });
  return __NormalLuncher;
}
deps["NormalLuncher"] = ["ErrorLog", "com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.LoaderSavingManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "flash.system.Capabilities", "flash.utils.ByteArray", "flash.utils.getTimer", "manager.ExternalInterfaceManager"];

defs["RegisterLuncher"] = function define($) {
  const __Base = $.Object;
  class __RegisterLuncher extends __Base {
    static $fields(self) {
    self._showLoadingTimerId = 0;
    self._loadingView = undefined;
    self._backShape = null;
    self._selectRoleView = null;
    self._stage = null;
    self._config = null;
    self._userInfo = null;
    self._callback = null;
    self._resourcesList = null;
    self._curLoadCount = 0;
    self._needLoadCount = 0;
    }
    constructor() {
         super();
      }
    lunch(param1, param2, param3, param4 = false, param5 = null) {
         this._stage = param3;
         this._config = param1;
         this._userInfo = param2;
         this._callback = param5;
         this._resourcesList = new ($.C("flash.utils.Dictionary"))(true);
         if(param4)
         {
            this._loadingView = $.C("loading.RegisterLoading").instance;
            this._showLoadingTimerId = $.C("flash.utils.setTimeout")(this._loadingView.show,1500);
         }
         else
         {
            this._loadingView = $.C("loading.SmallLoading").Instance;
         }
         this.loadResources();
      }
    loadResources() {
         this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("mainloadingii")] = 3;
         this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").ZhanPath] = 5;
         this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").AgentZhanPath] = 7;
         if($.C("com.pickgliss.loader.DisplayLoader").isDebug)
         {
            this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").LanguagePath] = 7;
            this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").NamesLibPath] = 7;
         }
         else
         {
            this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").LanguagePath] = 5;
            this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").NamesLibPath] = 5;
         }
         this._needLoadCount = this.getDicKeyNum(this._resourcesList);
         var _loc2_ = new ($.C("flash.net.URLVariables"))();
         _loc2_["rnd"] = $.C("com.pickgliss.ui.ComponentSetting").LOGIN_RND;
         for(var _loc1_ in this._resourcesList)
         {
            switch(this._resourcesList[_loc1_])
            {
               case 5:
               case 8:
               case 7:
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,this._resourcesList[_loc1_],8,$.bind(this, "onSingleLoadComplete"),$.bind(this, "onRegisterLoadProgress"),null,null,_loc2_);
                  break;
               default:
                  $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,this._resourcesList[_loc1_],8,$.bind(this, "onSingleLoadComplete"),$.bind(this, "onRegisterLoadProgress"));
            }
         }
      }
    onSingleLoadComplete(param1, param2) {
         this.saveContentByURL($.C("com.pickgliss.ui.ComponentSetting").ZhanPath,param1.url,param2,"text");
         this.saveContentByURL($.C("com.pickgliss.ui.ComponentSetting").AgentZhanPath,param1.url,param2,"text");
         this.saveContentByURL($.C("com.pickgliss.ui.ComponentSetting").LanguagePath,param1.url,param2,"text");
         this.saveContentByURL($.C("com.pickgliss.ui.ComponentSetting").NamesLibPath,param1.url,param2,"text");
         this._curLoadCount = this._curLoadCount + 1;
         if(this._curLoadCount >= this._needLoadCount)
         {
            $.C("flash.utils.clearTimeout")(this._showLoadingTimerId);
            this.parseResources();
         }
      }
    parseResources() {
         var _loc1_ = null;
         if(!$.C("manager.FilterWordManager").hasSetup)
         {
            _loc1_ = new ($.C("com.pickgliss.loader.FilterWordAnalyzer"))($.C("manager.FilterWordManager").setup);
            _loc1_.analyze(this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").ZhanPath]);
         }
         if(!$.C("manager.LanguageMgr").hasSetup)
         {
            _loc1_ = new ($.C("com.pickgliss.loader.LanguageAnalyzer"))($.C("manager.LanguageMgr").setup);
            _loc1_.analyze(this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").LanguagePath]);
         }
         if(!$.C("manager.AgentFilterManager").hasSetup)
         {
            $.C("manager.AgentFilterManager").Instance.setup(this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").AgentZhanPath]);
         }
         if(!$.C("manager.NamesLibManager").hasSetup)
         {
            _loc1_ = new ($.C("com.pickgliss.loader.NamesLibAnalyzer"))($.C("manager.NamesLibManager").setup);
            _loc1_.analyze(this._resourcesList[$.C("com.pickgliss.ui.ComponentSetting").NamesLibPath]);
         }
         $.C("com.pickgliss.ui.ComponentFactory").Instance.setup(new ($.C("RegisterUIConfig"))().getXML());
         this._loadingView.exit($.bind(this, "showRegisterView"));
      }
    saveContentByURL(param1, param2, param3, param4) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if(param2.indexOf(param1.toLowerCase()) >= 0)
         {
            switch(param4)
            {
               case "text":
                  this._resourcesList[param1] = String(param3);
                  break;
               case "xml":
                  this._resourcesList[param1] = $.XML(param3);
                  break;
               default:
                  throw new Error("Formato dos dados não definido");
            }
         }
      }
    getDicKeyNum(param1) {
         var _loc2_ = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
    onRegisterLoadProgress(param1) {
         var _loc2_ = param1.bytesLoaded / param1.bytesTotal * (this._curLoadCount / this._needLoadCount);
         this._loadingView.progress = $.int(50 + _loc2_ * 50);
      }
    showRegisterView(param1 = null) {
         this._backShape = new ($.C("flash.display.Shape"))();
         this._selectRoleView = new ($.C("register.MainFigureView"))(this._userInfo,$.bind(this, "lunchMaxLoadingII"));
         this._backShape.graphics.beginFill(0,1);
         this._backShape.graphics.drawRect(0,0,2400,1800);
         this._backShape.graphics.endFill();
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._backShape,0,true,true);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._selectRoleView,0,true,true,0,0,true);
         $.C("LoginPreload").load(false);
      }
    lunchMaxLoadingII() {
         var _loc2_ = $.C("loading.MaxLoadingII").Instance;
         _loc2_.show(this._selectRoleView);
         var _loc1_ = new ($.C("NormalLuncher"))();
         _loc1_.lunch(this._config,this._userInfo,this._stage,_loc2_,$.bind(this, "unload"));
      }
    unload() {
         $.C("flash.utils.clearTimeout")(this._showLoadingTimerId);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._backShape);
         this._backShape = null;
         if(this._selectRoleView)
         {
            this._selectRoleView.dispose();
         }
         this._selectRoleView = null;
         this._loadingView = null;
         this._stage = null;
         this._config = null;
         this._userInfo = null;
         this._resourcesList = null;
         if(this._callback != null)
         {
            this._callback();
            this._callback = null;
         }
      }
  }
  $.meta(__RegisterLuncher, "RegisterLuncher", []);
  $.statics(__RegisterLuncher, () => {
    __RegisterLuncher.UIMODULE_NAME = "mainloadingii";
    __RegisterLuncher.FORMAT_TEXT = "text";
    __RegisterLuncher.FORMAT_XML = "xml";
  });
  return __RegisterLuncher;
}
deps["RegisterLuncher"] = ["LoginPreload", "NormalLuncher", "RegisterUIConfig", "com.pickgliss.loader.DisplayLoader", "com.pickgliss.loader.FilterWordAnalyzer", "com.pickgliss.loader.LanguageAnalyzer", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.NamesLibAnalyzer", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Shape", "flash.net.URLVariables", "flash.utils.Dictionary", "flash.utils.clearTimeout", "flash.utils.setTimeout", "loading.MaxLoadingII", "loading.RegisterLoading", "loading.SmallLoading", "manager.AgentFilterManager", "manager.FilterWordManager", "manager.LanguageMgr", "manager.NamesLibManager", "register.MainFigureView"];

defs["RegisterUIConfig"] = function define($) {
  const __Base = $.Object;
  class __RegisterUIConfig extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    getXML() {
         return $.XML("<style name=\"mainloadingii\" source=\"ui/zh_cn/swf/mainloadingii.swf\">\n\t\t\t\t  <sets>\n\t\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"core.normal_f\" args=\"0x000000,1,5,5,3\" />\n\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"core.DefaultFilter\" args=\"1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0\" />\n\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"core.LightFilter\" args=\"1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0\"/>\n\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"core.GrayFilter\" args=\"0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0\"/>\n\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"core.DarkGrayFilter\" args=\"0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0,0,0,1,0\"/>\n\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"core.DarkFilter\" args=\"0.8,0,0,0,6.1,0,0.8,0,0,6.1,0,0,0.8,0,6.1,0,0,0,1,0\"/>\n\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"mainloadingii.register.ReNameTxt_t\" args=\"Arial,20,0xFFfA04,,,,,,center\" />\n\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"mainloadingii.register.renameFrameDescribeTxt_t\" args=\"Arial,12,0x13b541,,,,,,center\" />\n\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"mainloadingii.register.renameFrameDescribeErrorTxt_t\" args=\"Arial,12,0xFF0000,,,,,,center\" />\n\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"mainloadingii.register.commonTipTF\" args=\"Arial,14,0xffffff\" letterSpacing=\"1\" leading=\"3\"/>\n\t\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"mainloadingii.register.GlowFilter\" args=\"0x00a8ec,1,5,5,5\" />\n\t\t\t\t  </sets>\n\t\t\t\t  \n\t\t\t\t  <bitmaps>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_1\" x=\"508\" y=\"-16\" stylename=\"asset.mainloadingii.register.RoleIcon_1\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_2\" x=\"501\" y=\"43\" stylename=\"asset.mainloadingii.register.RoleIcon_2\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_3\" x=\"507\" y=\"2\" stylename=\"asset.mainloadingii.register.RoleIcon_3\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_4\" x=\"522\" y=\"-64\" stylename=\"asset.mainloadingii.register.RoleIcon_4\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_5\" x=\"554\" y=\"12\" stylename=\"asset.mainloadingii.register.RoleIcon_5\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.RoleIcon_6\" x=\"465\" y=\"-67\" stylename=\"asset.mainloadingii.register.RoleIcon_6\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head1\" x=\"17\" y=\"16\" stylename=\"asset.mainloadingii.register.head1\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head2\" x=\"17\" y=\"26\" stylename=\"asset.mainloadingii.register.head2\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head3\" x=\"19\" y=\"27\" stylename=\"asset.mainloadingii.register.head3\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head4\" x=\"27\" y=\"21\" stylename=\"asset.mainloadingii.register.head4\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head5\" x=\"19\" y=\"29\" stylename=\"asset.mainloadingii.register.head5\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.head6\" x=\"17\" y=\"16\" stylename=\"asset.mainloadingii.register.head6\"/>\n\t\t\t\t\t<bitmapData resourceLink=\"asset.mainloadingii.register.Back\" x=\"0\" y=\"0\" stylename=\"asset.mainloadingii.register.Back\"/>\n\t\t\t\t\n\t\t\t\n\t\t\t\t\n\t\t\t\t\n\t\t\t\t  </bitmaps>\n\t\t\t\t  \n\t\t\t\t  <customDisplay>\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp1\" x=\"189\" y=\"463\" />\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp2\" x=\"313\" y=\"449\" />\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp3\" x=\"439\" y=\"434\" />\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp4\" x=\"566\" y=\"420\" />\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp5\" x=\"691\" y=\"406\" />\n\t\t\t\t\t<custom classname=\"register.HeadComp\" stylename=\"mainloadingii.register.ChooseView.HeadComp6\" x=\"816\" y=\"392\" />\n\t\t\t\t\t<custom classname=\"asset.mainloadingii.register.MainFigureBg\" stylename=\"asset.mainloadingii.register.MainFigureBg\" x=\"75\" y=\"95\" />\n\t\t\t\t\t<custom classname=\"asset.mainloadingii.register.figureNameBg\" stylename=\"asset.mainloadingii.register.figureNameBg\" x=\"870\" y=\"593\" />\n\t\t\t\t\n\t\t\t\t\n\t\t\t\t  </customDisplay>\n\t\t\t\t  \n\t\t\t\t  <components>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.IconButton\" stylename=\"mainloadingii.register.ChooseView.ConfirmBtn\" backStyle=\"asset.mainloadingii.register.btnOkBg\" \n\t\t\t\t\t\ticonStyle=\"asset.mainloadingii.register.btnOkTxt\" iconInnerRectString=\"40,102,15,29,13\"\n\t\t\t\t\t\tdisplacement=\"true\" filterString=\"core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter\" alpha=\"1\" autoSizeAble=\"true\" buttonMode=\"true\" enable=\"true\" enableHtml=\"false\" iconFrameChange=\"true\" isFollowMouse=\"true\" mouseChildren=\"false\" mouseEnabled=\"true\" pressEnable=\"false\" scaleX=\"1\" scaleY=\"1\" tipGapH=\"0\" tipGapV=\"0\" x=\"899\" y=\"642\"/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.SelectedButton\" stylename=\"mainloadingii.register.ChooseView.PlayerBack\"  \n\t\t\t\t\t\tunSelectedStyle=\"asset.mainloadingii.register.PlayerBackUnselected\" selectedStyle=\"asset.mainloadingii.register.PlayerBackSelected\" \n\t\t\t\t\t\tfilterString=\"core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter\" \n\t\t\t\t\t\tx=\"300\" y=\"-35\"\n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.SelectedButton\" stylename=\"mainloadingii.register.ChooseView.PlayerNew\"  \n\t\t\t\t\t\tunSelectedStyle=\"asset.mainloadingii.register.PlayerNewUnselected\" selectedStyle=\"asset.mainloadingii.register.PlayerNewSelected\" \n\t\t\t\t\t\tfilterString=\"core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter\" \n\t\t\t\t\t\tx=\"550\" y=\"-35\"\n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"mainloadingii.register.ChooseView.commonTipBg\" \n\t\t\t\t\t\tresourceLink=\"asset.mainloadingii.register.TipsBg\" scaleGridString=\"10,10,250,70\" alpha=\"0.8\"\n\t\t\t\t\t\tx=\"460\" y=\"-25\"\n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"mainloadingii.register.ChooseView.commonTipText\" \n\t\t\t\t\t\ttextFormatStyle=\"mainloadingii.register.commonTipTF\"\n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"mainloadingii.register.ChooseView.ShaiziBtn\" \n\t\t\t\t\t\tbackStyle=\"asset.mainloadingii.register.ShaiziBtn\"  \n\t\t\t\t\t\tfilterString=\"core.DefaultFilter,mainloadingii.register.GlowFilter,core.DefaultFilter,core.GrayFilter\"\n\t\t\t\t\t\tx=\"1140\" y=\"590\"\n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"mainloadingii.register.ChooseView.ReNameTxt\" \n\t\t\t\t\t\ttextFormatStyle=\"mainloadingii.register.ReNameTxt_t\" autoSize=\"none\" \n\t\t\t\t\t\trestrict=\"^ \" type=\"input\" \n\t\t\t\t\t\theight=\"25\" width=\"153\" \n\t\t\t\t\t\tx=\"985\" y=\"590\" \n\t\t\t\t\t/>\n\t\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"mainloadingii.register.ChooseView.DescribeTxt\"\n\t\t\t\t\t\ttextFormatStyle=\"mainloadingii.register.renameFrameDescribeErrorTxt_t,mainloadingii.register.renameFrameDescribeTxt_t\" autoSize=\"none\"\n\t\t\t\t\t\theight=\"20\"  width=\"200\" \n\t\t\t\t\t\tx=\"913\" y=\"627\" \n\t\t\t\t\t/>\n\t\t\t\t  </components>\n\t\t\t\t</style>");
      }
  }
  $.meta(__RegisterUIConfig, "RegisterUIConfig", []);
  return __RegisterUIConfig;
}
deps["RegisterUIConfig"] = [];

defs["asset.loading.LogoAsset"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __LogoAsset extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.addFrameScript(95,$.bind(this, "frame96"));
      }
    frame96() {
         this.stop();
      }
  }
  $.meta(__LogoAsset, "asset.loading.LogoAsset", []);
  return __LogoAsset;
}
deps["asset.loading.LogoAsset"] = ["flash.display.MovieClip"];

defs["asset.loading.LogoBgAsset"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __LogoBgAsset extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__LogoBgAsset, "asset.loading.LogoBgAsset", []);
  return __LogoBgAsset;
}
deps["asset.loading.LogoBgAsset"] = ["flash.display.MovieClip"];

defs["asset.loading.SmallLoadingAsset"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __SmallLoadingAsset extends __Base {
    static $fields(self) {
    self.PercentageMc = null;
    }
    constructor() {
         super();
      }
  }
  $.meta(__SmallLoadingAsset, "asset.loading.SmallLoadingAsset", []);
  return __SmallLoadingAsset;
}
deps["asset.loading.SmallLoadingAsset"] = ["flash.display.MovieClip"];

defs["asset.queue.QueueAsset"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __QueueAsset extends __Base {
    static $fields(self) {
    self.timeTxt = null;
    self.numberPos = null;
    self.countTxt = null;
    }
    constructor() {
         super();
      }
  }
  $.meta(__QueueAsset, "asset.queue.QueueAsset", []);
  return __QueueAsset;
}
deps["asset.queue.QueueAsset"] = ["flash.display.MovieClip"];

defs["asset.queue.QueueNumberAsset"] = function define($) {
  const __Base = $.C("flash.display.BitmapData");
  class __QueueNumberAsset extends __Base {
    static $fields(self) {
    }
    constructor(param1 = 200, param2 = 22) {
         super(param1,param2);
      }
  }
  $.meta(__QueueNumberAsset, "asset.queue.QueueNumberAsset", []);
  return __QueueNumberAsset;
}
deps["asset.queue.QueueNumberAsset"] = ["flash.display.BitmapData"];

defs["asset.smallloading.RegisterLoadingMc"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __RegisterLoadingMc extends __Base {
    static $fields(self) {
    self.tiptxt = null;
    self.bg1 = null;
    self.bg2 = null;
    }
    constructor() {
         super();
         this.addFrameScript(0,$.bind(this, "frame1"));
      }
    frame1() {
         this.stop();
      }
  }
  $.meta(__RegisterLoadingMc, "asset.smallloading.RegisterLoadingMc", []);
  return __RegisterLoadingMc;
}
deps["asset.smallloading.RegisterLoadingMc"] = ["flash.display.MovieClip"];

defs["asset.smallloading.RegisterLoadingMc2"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __RegisterLoadingMc2 extends __Base {
    static $fields(self) {
    self.tiptxt = null;
    self.bg1 = null;
    self.bg2 = null;
    }
    constructor() {
         super();
         this.addFrameScript(0,$.bind(this, "frame1"));
      }
    frame1() {
         this.stop();
      }
  }
  $.meta(__RegisterLoadingMc2, "asset.smallloading.RegisterLoadingMc2", []);
  return __RegisterLoadingMc2;
}
deps["asset.smallloading.RegisterLoadingMc2"] = ["flash.display.MovieClip"];

defs["com.greensock.plugins.MotionBlurPlugin"] = function define($) {
  const __Base = $.C("com.greensock.plugins.TweenPlugin");
  class __MotionBlurPlugin extends __Base {
    static $fields(self) {
    self._target = null;
    self._time = NaN;
    self._xCurrent = NaN;
    self._yCurrent = NaN;
    self._bd = null;
    self._bitmap = null;
    self._strength = 0.05;
    self._tween = null;
    self._blur = new ($.C("flash.filters.BlurFilter"))(0,0,2);
    self._matrix = new ($.C("flash.geom.Matrix"))();
    self._sprite = null;
    self._rect = null;
    self.$$_angle = NaN;
    self.$$_alpha = NaN;
    self._xRef = NaN;
    self._yRef = NaN;
    self.$$_mask = null;
    self._padding = 0;
    self._bdCache = null;
    self._rectCache = null;
    self._cos = NaN;
    self._sin = NaN;
    self._smoothing = false;
    self._xOffset = NaN;
    self._yOffset = NaN;
    self._cached = false;
    self._fastMode = false;
    }
    constructor() {
         super();
         this.propName = "motionBlur";
         this.overwriteProps = ["motionBlur"];
         this.onComplete = $.bind(this, "disable");
         this.onDisable = $.bind(this, "onTweenDisable");
         this.priority = -2;
         this.activeDisable = true;
      }
    onInitTween(param1, param2, param3) {
         var _loc4_ = NaN;
         var _loc5_ = NaN;
         if(!($.is(param1, $.C("flash.display.DisplayObject"))))
         {
            throw new Error("motionBlur tweens only work for DisplayObjects.");
         }
         if(param2 == false)
         {
            this._strength = 0;
         }
         else if(typeof param2 == "object")
         {
            this._strength = (param2.strength || 1) * 0.05;
            this._blur.quality = $.int(param2.quality) || 2;
            this._fastMode = param2.fastMode == true;
         }
         if(!__MotionBlurPlugin._classInitted)
         {
            try
            {
               __MotionBlurPlugin._isFlex = Boolean($.C("flash.utils.getDefinitionByName")("mx.managers.SystemManager"));
            }
            catch(e)
            {
               __MotionBlurPlugin._isFlex = false;
            }
            __MotionBlurPlugin._classInitted = true;
         }
         this._target = $.as(param1, $.C("flash.display.DisplayObject"));
         this._tween = param3;
         this._time = 0;
         this._padding = "padding" in param2 ? $.int(param2.padding) : 10;
         this._smoothing = this._blur.quality > 1;
         this._xCurrent = this._xRef = this._target.x;
         this._yCurrent = this._yRef = this._target.y;
         this.$$_alpha = this._target.alpha;
         if("x" in this._tween.propTweenLookup && "y" in this._tween.propTweenLookup && !this._tween.propTweenLookup.x.isPlugin && !this._tween.propTweenLookup.y.isPlugin)
         {
            this.$$_angle = 3.141592653589793 - Math.atan2(this._tween.propTweenLookup.y.change,this._tween.propTweenLookup.x.change);
         }
         else if(this._tween.vars.x != null || this._tween.vars.y != null)
         {
            _loc4_ = Number(this._tween.vars.x || this._target.x);
            _loc5_ = Number(this._tween.vars.y || this._target.y);
            this.$$_angle = 3.141592653589793 - Math.atan2(_loc5_ - this._target.y,_loc4_ - this._target.x);
         }
         else
         {
            this.$$_angle = 0;
         }
         this._cos = Math.cos(this.$$_angle);
         this._sin = Math.sin(this.$$_angle);
         this._bd = new ($.C("flash.display.BitmapData"))(this._target.width + this._padding * 2,this._target.height + this._padding * 2,true,16777215);
         this._bdCache = this._bd.clone();
         this._bitmap = new ($.C("flash.display.Bitmap"))(this._bd);
         this._bitmap.smoothing = this._smoothing;
         this._sprite = __MotionBlurPlugin._isFlex ? new ($.C("flash.utils.getDefinitionByName")("mx.core.UIComponent"))() : new ($.C("flash.display.Sprite"))();
         this._sprite.mouseEnabled = this._sprite.mouseChildren = false;
         this._sprite.addChild(this._bitmap);
         this._rectCache = new ($.C("flash.geom.Rectangle"))(0,0,this._bd.width,this._bd.height);
         this._rect = this._rectCache.clone();
         if(this._target.mask)
         {
            this.$$_mask = this._target.mask;
         }
         return true;
      }
    disable() {
         if(this._strength != 0)
         {
            this._target.alpha = this.$$_alpha;
         }
         if(this._sprite.parent)
         {
            if(__MotionBlurPlugin._isFlex && this._sprite.parent.hasOwnProperty("removeElement"))
            {
               ($.as(this._sprite.parent, "Object")).removeElement(this._sprite);
            }
            else
            {
               this._sprite.parent.removeChild(this._sprite);
            }
         }
         if(this.$$_mask)
         {
            this._target.mask = this.$$_mask;
         }
      }
    onTweenDisable() {
         if(this._tween.cachedTime != this._tween.cachedDuration && this._tween.cachedTime != 0)
         {
            this.disable();
         }
      }
    set changeFactor(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc11_ = null;
         var _loc7_ = false;
         var _loc8_ = null;
         var _loc12_ = NaN;
         var _loc2_ = NaN;
         var _loc9_ = NaN;
         var _loc10_ = this._tween.cachedTime - this._time;
         if(_loc10_ < 0)
         {
            _loc10_ = -_loc10_;
         }
         if(_loc10_ < 1e-7)
         {
            return;
         }
         var _loc3_ = this._target.x - this._xCurrent;
         var _loc4_ = this._target.y - this._yCurrent;
         var _loc5_ = this._target.x - this._xRef;
         var _loc6_ = this._target.y - this._yRef;
         this._changeFactor = param1;
         if(_loc5_ > 2 || _loc6_ > 2 || _loc5_ < -2 || _loc6_ < -2)
         {
            this.$$_angle = 3.141592653589793 - Math.atan2(_loc6_,_loc5_);
            this._cos = Math.cos(this.$$_angle);
            this._sin = Math.sin(this.$$_angle);
            this._xRef = this._target.x;
            this._yRef = this._target.y;
         }
         this._blur.blurX = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_) * this._strength / _loc10_;
         this._xCurrent = this._target.x;
         this._yCurrent = this._target.y;
         this._time = this._tween.cachedTime;
         if(param1 == 0 || this._target.parent == null)
         {
            this.disable();
            return;
         }
         if(this._sprite.parent != this._target.parent && this._target.parent)
         {
            if(__MotionBlurPlugin._isFlex && this._target.parent.hasOwnProperty("addElement"))
            {
               ($.as(this._target.parent, "Object")).addElementAt(this._sprite,($.as(this._target.parent, "Object")).getElementIndex(this._target));
            }
            else
            {
               this._target.parent.addChildAt(this._sprite,this._target.parent.getChildIndex(this._target));
            }
            if(this.$$_mask)
            {
               this._sprite.mask = this.$$_mask;
            }
         }
         if(!this._fastMode || !this._cached)
         {
            _loc11_ = this._target.parent.filters;
            if(_loc11_.length != 0)
            {
               this._target.parent.filters = __MotionBlurPlugin._blankArray;
            }
            this._target.x = this._target.y = 20000;
            _loc7_ = this._target.visible;
            this._target.visible = true;
            _loc8_ = this._target.getBounds(this._target.parent);
            if(_loc8_.width + this._blur.blurX * 2 > 2870)
            {
               this._blur.blurX = _loc8_.width >= 2870 ? 0 : (2870 - _loc8_.width) * 0.5;
            }
            this._xOffset = 20000 - _loc8_.x + this._padding;
            this._yOffset = 20000 - _loc8_.y + this._padding;
            _loc8_.width += this._padding * 2;
            _loc8_.height += this._padding * 2;
            if(_loc8_.height > this._bdCache.height || _loc8_.width > this._bdCache.width)
            {
               this._bdCache = new ($.C("flash.display.BitmapData"))(_loc8_.width,_loc8_.height,true,16777215);
               this._rectCache = new ($.C("flash.geom.Rectangle"))(0,0,this._bdCache.width,this._bdCache.height);
            }
            this._matrix.tx = this._padding - _loc8_.x;
            this._matrix.ty = this._padding - _loc8_.y;
            this._matrix.a = this._matrix.d = 1;
            this._matrix.b = this._matrix.c = 0;
            _loc8_.x = _loc8_.y = 0;
            if(this._target.alpha == 0.00390625)
            {
               this._target.alpha = this.$$_alpha;
            }
            else
            {
               this.$$_alpha = this._target.alpha;
            }
            this._bdCache.fillRect(this._rectCache,16777215);
            this._bdCache.draw(this._target.parent,this._matrix,__MotionBlurPlugin._ct,"normal",_loc8_,this._smoothing);
            this._target.visible = _loc7_;
            this._target.x = this._xCurrent;
            this._target.y = this._yCurrent;
            if(_loc11_.length != 0)
            {
               this._target.parent.filters = _loc11_;
            }
            this._cached = true;
         }
         else if(this._target.alpha != 0.00390625)
         {
            this.$$_alpha = this._target.alpha;
         }
         this._target.alpha = 0.00390625;
         this._matrix.tx = this._matrix.ty = 0;
         this._matrix.a = this._cos;
         this._matrix.b = this._sin;
         this._matrix.c = -this._sin;
         this._matrix.d = this._cos;
         _loc9_ = this._matrix.a * this._bdCache.width;
         if(_loc9_ < 0)
         {
            this._matrix.tx = -_loc9_;
            _loc9_ = -_loc9_;
         }
         _loc2_ = this._matrix.c * this._bdCache.height;
         if(_loc2_ < 0)
         {
            this._matrix.tx -= _loc2_;
            _loc9_ -= _loc2_;
         }
         else
         {
            _loc9_ += _loc2_;
         }
         _loc12_ = this._matrix.d * this._bdCache.height;
         if(_loc12_ < 0)
         {
            this._matrix.ty = -_loc12_;
            _loc12_ = -_loc12_;
         }
         _loc2_ = this._matrix.b * this._bdCache.width;
         if(_loc2_ < 0)
         {
            this._matrix.ty -= _loc2_;
            _loc12_ -= _loc2_;
         }
         else
         {
            _loc12_ += _loc2_;
         }
         _loc9_ += this._blur.blurX * 2;
         this._matrix.tx += this._blur.blurX;
         if(_loc9_ > this._bd.width || _loc12_ > this._bd.height)
         {
            this._bd = this._bitmap.bitmapData = new ($.C("flash.display.BitmapData"))(_loc9_,_loc12_,true,16777215);
            this._rect = new ($.C("flash.geom.Rectangle"))(0,0,this._bd.width,this._bd.height);
            this._bitmap.smoothing = this._smoothing;
         }
         this._bd.fillRect(this._rect,16777215);
         this._bd.draw(this._bdCache,this._matrix,__MotionBlurPlugin._ct,"normal",this._rect,this._smoothing);
         this._bd.applyFilter(this._bd,this._rect,__MotionBlurPlugin._point,this._blur);
         this._bitmap.x = 0 - (this._matrix.a * this._xOffset + this._matrix.c * this._yOffset + this._matrix.tx);
         this._bitmap.y = 0 - (this._matrix.d * this._yOffset + this._matrix.b * this._xOffset + this._matrix.ty);
         this._matrix.b = -this._sin;
         this._matrix.c = this._sin;
         this._matrix.tx = this._xCurrent;
         this._matrix.ty = this._yCurrent;
         this._sprite.transform.matrix = this._matrix;
      }
    get changeFactor() { return super.changeFactor; }
  }
  $.meta(__MotionBlurPlugin, "com.greensock.plugins.MotionBlurPlugin", []);
  $.statics(__MotionBlurPlugin, () => {
    __MotionBlurPlugin.API = 1;
    __MotionBlurPlugin._DEG2RAD = 0.017453292519943295;
    __MotionBlurPlugin._RAD2DEG = 57.29577951308232;
    __MotionBlurPlugin._classInitted = false;
    __MotionBlurPlugin._isFlex = false;
    __MotionBlurPlugin._point = new ($.C("flash.geom.Point"))(0,0);
    __MotionBlurPlugin._ct = new ($.C("flash.geom.ColorTransform"))();
    __MotionBlurPlugin._blankArray = [];
  });
  return __MotionBlurPlugin;
}
deps["com.greensock.plugins.MotionBlurPlugin"] = ["com.greensock.plugins.TweenPlugin", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.DisplayObject", "flash.display.Sprite", "flash.filters.BlurFilter", "flash.geom.ColorTransform", "flash.geom.Matrix", "flash.geom.Point", "flash.geom.Rectangle", "flash.utils.getDefinitionByName"];

defs["com.greensock.plugins.TransformAroundCenterPlugin"] = function define($) {
  const __Base = $.C("com.greensock.plugins.TransformAroundPointPlugin");
  class __TransformAroundCenterPlugin extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.propName = "transformAroundCenter";
      }
    onInitTween(param1, param2, param3) {
         var _loc5_ = null;
         var _loc8_ = false;
         var _loc6_ = $.as(param1, $.C("flash.display.DisplayObject"));
         if(_loc6_.parent == null)
         {
            _loc8_ = true;
            _loc5_ = new ($.C("flash.display.Sprite"))();
            _loc5_.addChild(_loc6_);
         }
         var _loc4_ = _loc6_.getBounds(_loc6_.parent);
         param2.point = new ($.C("flash.geom.Point"))(_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5);
         if(_loc8_)
         {
            _loc6_.parent.removeChild(_loc6_);
         }
         var _loc7_ = super.onInitTween(_loc6_,param2,param3);
         if(_loc4_.width < 1 || _loc4_.height < 1)
         {
            _loc4_ = _loc6_.getBounds(_loc6_);
            this._local = new ($.C("flash.geom.Point"))(_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5);
         }
         return _loc7_;
      }
  }
  $.meta(__TransformAroundCenterPlugin, "com.greensock.plugins.TransformAroundCenterPlugin", []);
  $.statics(__TransformAroundCenterPlugin, () => {
    __TransformAroundCenterPlugin.API = 1;
  });
  return __TransformAroundCenterPlugin;
}
deps["com.greensock.plugins.TransformAroundCenterPlugin"] = ["com.greensock.plugins.TransformAroundPointPlugin", "flash.display.DisplayObject", "flash.display.Sprite", "flash.geom.Point"];

defs["com.greensock.plugins.TransformAroundPointPlugin"] = function define($) {
  const __Base = $.C("com.greensock.plugins.TweenPlugin");
  class __TransformAroundPointPlugin extends __Base {
    static $fields(self) {
    self._target = null;
    self._local = null;
    self._point = null;
    self._shortRotation = null;
    self._proxy = null;
    self._proxySizeData = null;
    }
    constructor() {
         super();
         this.propName = "transformAroundPoint";
         this.overwriteProps = ["x","y"];
         this.priority = -1;
      }
    onInitTween(param1, param2, param3) {
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc5_ = null;
         var _loc11_ = null;
         var _loc4_ = null;
         var _loc12_ = null;
         var _loc14_ = null;
         var _loc8_ = null;
         var _loc13_ = null;
         var _loc9_ = NaN;
         var _loc10_ = NaN;
         if(!($.is(param2.point, $.C("flash.geom.Point"))))
         {
            return false;
         }
         this._target = $.as(param1, $.C("flash.display.DisplayObject"));
         this._point = param2.point.clone();
         this._local = this._target.globalToLocal(this._target.parent.localToGlobal(this._point));
         if(!__TransformAroundPointPlugin._classInitted)
         {
            try
            {
               __TransformAroundPointPlugin._isFlex = Boolean($.C("flash.utils.getDefinitionByName")("mx.managers.SystemManager"));
            }
            catch(e)
            {
               __TransformAroundPointPlugin._isFlex = false;
            }
            __TransformAroundPointPlugin._classInitted = true;
         }
         if((!isNaN(param2.width) || !isNaN(param2.height)) && this._target.parent != null)
         {
            _loc6_ = this._target.transform.matrix;
            _loc7_ = this._target.parent.globalToLocal(this._target.localToGlobal(new ($.C("flash.geom.Point"))(100,100)));
            this._target.width *= 2;
            if(_loc7_.x == this._target.parent.globalToLocal(this._target.localToGlobal(new ($.C("flash.geom.Point"))(100,100))).x)
            {
               this._proxy = this._target;
               this._target.rotation = 0;
               this._proxySizeData = {};
               if(!isNaN(param2.width))
               {
                  this.addTween(this._proxySizeData,"width",this._target.width / 2,param2.width,"width");
               }
               if(!isNaN(param2.height))
               {
                  this.addTween(this._proxySizeData,"height",this._target.height,param2.height,"height");
               }
               _loc5_ = this._target.getBounds(this._target);
               _loc11_ = new ($.C("flash.display.Sprite"))();
               _loc4_ = __TransformAroundPointPlugin._isFlex ? new ($.C("flash.utils.getDefinitionByName")("mx.core.UIComponent"))() : new ($.C("flash.display.Sprite"))();
               _loc4_.addChild(_loc11_);
               _loc4_.visible = false;
               this._proxy.parent.addChild(_loc4_);
               this._target = _loc11_;
               _loc11_.graphics.beginFill(255,0.4);
               _loc11_.graphics.drawRect(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
               _loc11_.graphics.endFill();
               _loc11_.transform.matrix = this._target.transform.matrix = _loc6_;
            }
            else
            {
               this._target.transform.matrix = _loc6_;
            }
         }
         for(_loc8_ in param2)
         {
            if(_loc8_ != "point")
            {
               if(_loc8_ == "shortRotation")
               {
                  this._shortRotation = new ($.C("com.greensock.plugins.ShortRotationPlugin"))();
                  this._shortRotation.onInitTween(this._target,param2[_loc8_],param3);
                  this.addTween(this._shortRotation,"changeFactor",0,1,"shortRotation");
                  for(_loc14_ in param2[_loc8_])
                  {
                     this.overwriteProps[this.overwriteProps.length] = _loc14_;
                  }
               }
               else if(_loc8_ == "x" || _loc8_ == "y")
               {
                  this.addTween(this._point,_loc8_,this._point[_loc8_],param2[_loc8_],_loc8_);
                  this.overwriteProps[this.overwriteProps.length] = _loc8_;
               }
               else if(_loc8_ == "scale")
               {
                  this.addTween(this._target,"scaleX",this._target.scaleX,param2.scale,"scaleX");
                  this.addTween(this._target,"scaleY",this._target.scaleY,param2.scale,"scaleY");
                  this.overwriteProps[this.overwriteProps.length] = "scaleX";
                  this.overwriteProps[this.overwriteProps.length] = "scaleY";
               }
               else if(!((_loc8_ == "width" || _loc8_ == "height") && this._proxy != null))
               {
                  this.addTween(this._target,_loc8_,this._target[_loc8_],param2[_loc8_],_loc8_);
                  this.overwriteProps[this.overwriteProps.length] = _loc8_;
               }
            }
         }
         if(param3 != null)
         {
            _loc13_ = param3.vars;
            if("x" in _loc13_ || "y" in _loc13_)
            {
               if("x" in _loc13_)
               {
                  _loc10_ = Number(typeof _loc13_.x == "number" ? _loc13_.x : this._target.x + Number(_loc13_.x));
               }
               if("y" in _loc13_)
               {
                  _loc9_ = Number(typeof _loc13_.y == "number" ? _loc13_.y : this._target.y + Number(_loc13_.y));
               }
               param3.killVars({
                  "x":true,
                  "y":true
               },false);
               this.changeFactor = 1;
               if(!isNaN(_loc10_))
               {
                  this.addTween(this._point,"x",this._point.x,this._point.x + (_loc10_ - this._target.x),"x");
               }
               if(!isNaN(_loc9_))
               {
                  this.addTween(this._point,"y",this._point.y,this._point.y + (_loc9_ - this._target.y),"y");
               }
               this.changeFactor = 0;
            }
         }
         return true;
      }
    killProps(param1) {
         if(this._shortRotation != null)
         {
            this._shortRotation.killProps(param1);
            if(this._shortRotation.overwriteProps.length == 0)
            {
               param1.shortRotation = true;
            }
         }
         super.killProps(param1);
      }
    set changeFactor(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc6_ = NaN;
         var _loc7_ = NaN;
         var _loc2_ = NaN;
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = NaN;
         if(this._proxy != null && this._proxy.parent != null)
         {
            this._proxy.parent.addChild(this._target.parent);
         }
         if(this._target.parent)
         {
            var _loc8_ = $.int(this._tweens.length);
            if(this.round)
            {
               while(--_loc8_ > -1)
               {
                  _loc5_ = this._tweens[_loc8_];
                  _loc2_ = _loc5_.start + _loc5_.change * param1;
                  _loc5_.target[_loc5_.property] = _loc2_ > 0 ? $.int(_loc2_ + 0.5) : $.int(_loc2_ - 0.5);
               }
               _loc3_ = this._target.parent.globalToLocal(this._target.localToGlobal(this._local));
               _loc6_ = this._target.x + this._point.x - _loc3_.x;
               _loc7_ = this._target.y + this._point.y - _loc3_.y;
               this._target.x = _loc6_ > 0 ? $.int(_loc6_ + 0.5) : $.int(_loc6_ - 0.5);
               this._target.y = _loc7_ > 0 ? $.int(_loc7_ + 0.5) : $.int(_loc7_ - 0.5);
            }
            else
            {
               while(--_loc8_ > -1)
               {
                  _loc5_ = this._tweens[_loc8_];
                  _loc5_.target[_loc5_.property] = _loc5_.start + _loc5_.change * param1;
               }
               _loc3_ = this._target.parent.globalToLocal(this._target.localToGlobal(this._local));
               this._target.x += this._point.x - _loc3_.x;
               this._target.y += this._point.y - _loc3_.y;
            }
         }
         this._changeFactor = param1;
         if(this._proxy != null && this._proxy.parent != null)
         {
            _loc4_ = this._target.rotation;
            this._proxy.rotation = this._target.rotation = 0;
            if(this._proxySizeData.width != undefined)
            {
               this._proxy.width = this._target.width = this._proxySizeData.width;
            }
            if(this._proxySizeData.height != undefined)
            {
               this._proxy.height = this._target.height = this._proxySizeData.height;
            }
            this._proxy.rotation = this._target.rotation = _loc4_;
            _loc3_ = this._target.parent.globalToLocal(this._target.localToGlobal(this._local));
            _loc6_ = this._target.x + this._point.x - _loc3_.x;
            _loc7_ = this._target.y + this._point.y - _loc3_.y;
            if(this.round)
            {
               this._proxy.x = _loc6_ > 0 ? $.int(_loc6_ + 0.5) : $.int(_loc6_ - 0.5);
               this._proxy.y = _loc7_ > 0 ? $.int(_loc7_ + 0.5) : $.int(_loc7_ - 0.5);
            }
            else
            {
               this._proxy.x = _loc6_;
               this._proxy.y = _loc7_;
            }
            this._proxy.parent.removeChild(this._target.parent);
         }
      }
    get changeFactor() { return super.changeFactor; }
  }
  $.meta(__TransformAroundPointPlugin, "com.greensock.plugins.TransformAroundPointPlugin", []);
  $.statics(__TransformAroundPointPlugin, () => {
    __TransformAroundPointPlugin.API = 1;
    __TransformAroundPointPlugin._classInitted = false;
    __TransformAroundPointPlugin._isFlex = false;
  });
  return __TransformAroundPointPlugin;
}
deps["com.greensock.plugins.TransformAroundPointPlugin"] = ["com.greensock.plugins.ShortRotationPlugin", "com.greensock.plugins.TweenPlugin", "flash.display.DisplayObject", "flash.display.Sprite", "flash.geom.Point", "flash.utils.getDefinitionByName"];

defs["com.hurlant.crypto.prng.ARC4"] = function define($) {
  const __Base = $.Object;
  class __ARC4 extends __Base {
    static $fields(self) {
    self.S = null;
    self.i = 0;
    self.j = 0;
    self.psize = 256;
    }
    constructor(param1 = null) {
         super();
         this.S = new ($.C("flash.utils.ByteArray"))();
         if(param1)
         {
            this.init(param1);
         }
      }
    decrypt(param1) {
         this.encrypt(param1);
      }
    init(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 256)
         {
            this.S[_loc2_] = _loc2_;
            _loc2_++;
         }
         _loc3_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 256)
         {
            _loc3_ = _loc3_ + this.S[_loc2_] + param1[_loc2_ % param1.length] & 0xFF;
            _loc4_ = $.int(this.S[_loc2_]);
            this.S[_loc2_] = this.S[_loc3_];
            this.S[_loc3_] = _loc4_;
            _loc2_++;
         }
         this.i = 0;
         this.j = 0;
      }
    dispose() {
         var _loc1_ = 0;
         _loc1_ = 0;
         if(this.S != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.S.length)
            {
               this.S[_loc1_] = Math.random() * 256;
               _loc1_++;
            }
            this.S.length = 0;
            this.S = null;
         }
         this.i = 0;
         this.j = 0;
         $.C("com.hurlant.util.Memory").gc();
      }
    encrypt(param1) {
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            var _temp_2 = param1;
            var _loc3_ = _loc2_++;
            _temp_2[_loc3_] ^= this.next();
         }
      }
    next() {
         var _loc1_ = 0;
         this.i = this.i + 1 & 0xFF;
         this.j = this.j + this.S[this.i] & 0xFF;
         _loc1_ = $.int(this.S[this.i]);
         this.S[this.i] = this.S[this.j];
         this.S[this.j] = _loc1_;
         return this.S[_loc1_ + this.S[this.i] & 0xFF];
      }
    getBlockSize() {
         return 1;
      }
    getPoolSize() {
         return this.psize;
      }
    toString() {
         return "rc4";
      }
  }
  $.meta(__ARC4, "com.hurlant.crypto.prng.ARC4", ["IPRNG", "IStreamCipher"]);
  return __ARC4;
}
deps["com.hurlant.crypto.prng.ARC4"] = ["com.hurlant.util.Memory", "flash.utils.ByteArray"];

defs["com.hurlant.crypto.prng.IPRNG"] = function define($) {
  return $.interface("com.hurlant.crypto.prng.IPRNG", []);
}

defs["com.hurlant.crypto.prng.Random"] = function define($) {
  const __Base = $.Object;
  class __Random extends __Base {
    static $fields(self) {
    self.psize = 0;
    self.ready = false;
    self.seeded = false;
    self.state = null;
    self.pool = null;
    self.pptr = 0;
    }
    constructor(param1 = null) {
         var _loc2_ = 0;
         super();
         if(param1 == null)
         {
            param1 = $.C("com.hurlant.crypto.prng.ARC4");
         }
         this.state = $.as(new param1(), $.C("com.hurlant.crypto.prng.IPRNG"));
         this.psize = this.state.getPoolSize();
         this.pool = new ($.C("flash.utils.ByteArray"))();
         this.pptr = 0;
         while(this.pptr < this.psize)
         {
            _loc2_ = 65536 * Math.random();
            this.pool[this.pptr++] = _loc2_ >>> 8;
            var _loc4_;
            this.pool[_loc4_ = this.pptr++] = _loc2_ & 0xFF;
         }
         this.pptr = 0;
         this.seed();
      }
    seed(param1 = 0) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1 == 0)
         {
            param1 = new Date().getTime();
         }
         var _temp_3 = this.pool;
         var _loc2_ = this.pptr++;
         _temp_3[_loc2_] ^= param1 & 0xFF;
         var _temp_6 = this.pool;
         var _loc3_ = this.pptr++;
         _temp_6[_loc3_] ^= param1 >> 8 & 0xFF;
         var _loc4_;
         this.pool[_loc4_ = this.pptr++] = this.pool[_loc4_] ^ param1 >> 16 & 0xFF;
         var _loc5_;
         this.pool[_loc5_ = this.pptr++] = this.pool[_loc5_] ^ param1 >> 24 & 0xFF;
         this.pptr %= this.psize;
         this.seeded = true;
      }
    toString() {
         return "random-" + this.state.toString();
      }
    dispose() {
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.pool.length)
         {
            this.pool[_loc1_] = Math.random() * 256;
            _loc1_++;
         }
         this.pool.length = 0;
         this.pool = null;
         this.state.dispose();
         this.state = null;
         this.psize = 0;
         this.pptr = 0;
         $.C("com.hurlant.util.Memory").gc();
      }
    autoSeed() {
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         _loc1_ = new ($.C("flash.utils.ByteArray"))();
         _loc1_.writeUnsignedInt($.C("flash.system.System").totalMemory);
         _loc1_.writeUTF($.C("flash.system.Capabilities").serverString);
         _loc1_.writeUnsignedInt($.C("flash.utils.getTimer")());
         _loc1_.writeUnsignedInt(new Date().getTime());
         _loc2_ = $.C("flash.text.Font").enumerateFonts(true);
         for (_loc3_ of $.values(_loc2_))
         {
            _loc1_.writeUTF(_loc3_.fontName);
            _loc1_.writeUTF(_loc3_.fontStyle);
            _loc1_.writeUTF(_loc3_.fontType);
         }
         _loc1_.position = 0;
         while(_loc1_.bytesAvailable >= 4)
         {
            this.seed(_loc1_.readUnsignedInt());
         }
      }
    nextByte() {
         if(!this.ready)
         {
            if(!this.seeded)
            {
               this.autoSeed();
            }
            this.state.init(this.pool);
            this.pool.length = 0;
            this.pptr = 0;
            this.ready = true;
         }
         return this.state.next();
      }
    nextBytes(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         while(param2--)
         {
            param1.writeByte(this.nextByte());
         }
      }
  }
  $.meta(__Random, "com.hurlant.crypto.prng.Random", []);
  return __Random;
}
deps["com.hurlant.crypto.prng.Random"] = ["com.hurlant.crypto.prng.ARC4", "com.hurlant.crypto.prng.IPRNG", "com.hurlant.util.Memory", "flash.system.Capabilities", "flash.system.System", "flash.text.Font", "flash.utils.ByteArray", "flash.utils.getTimer"];

defs["com.hurlant.crypto.rsa.RSAKey"] = function define($) {
  const __Base = $.Object;
  class __RSAKey extends __Base {
    static $fields(self) {
    self.dmp1 = null;
    self.canDecrypt = false;
    self.d = null;
    self.e = 0;
    self.dmq1 = null;
    self.n = null;
    self.p = null;
    self.q = null;
    self.canEncrypt = false;
    self.coeff = null;
    }
    constructor(param1, param2, param3 = null, param4 = null, param5 = null, param6 = null, param7 = null, param8 = null) {
         super();
         this.n = param1;
         this.e = param2;
         this.d = param3;
         this.p = param4;
         this.q = param5;
         this.dmp1 = param6;
         this.dmq1 = param7;
         this.coeff = param8;
         this.canEncrypt = this.n != null && this.e != 0;
         this.canDecrypt = this.canEncrypt && this.d != null;
      }
    static bigRandom(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc4_ = null;
         if(param1 < 2)
         {
            return $.C("com.hurlant.math.BigInteger").nbv(1);
         }
         _loc3_ = new ($.C("flash.utils.ByteArray"))();
         param2.nextBytes(_loc3_,param1 >> 3);
         _loc3_.position = 0;
         _loc4_ = new ($.C("com.hurlant.math.BigInteger"))(_loc3_);
         _loc4_.primify(param1,1);
         return _loc4_;
      }
    static parsePublicKey(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         return new (__RSAKey)(new ($.C("com.hurlant.math.BigInteger"))(param1,16),parseInt(param2,16));
      }
    static generate(param1, param2) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc8_ = null;
         var _loc9_ = null;
         var _loc10_ = null;
         _loc3_ = new ($.C("com.hurlant.crypto.prng.Random"))();
         _loc4_ = $.uint(param1 >> 1);
         _loc5_ = new (__RSAKey)(null,0,null);
         _loc5_.e = parseInt(param2,16);
         _loc6_ = new ($.C("com.hurlant.math.BigInteger"))(param2,16);
         do
         {
            do
            {
               _loc5_.p = __RSAKey.bigRandom(param1 - _loc4_,_loc3_);
            }
            while(!(_loc5_.p.subtract($.C("com.hurlant.math.BigInteger").ONE).gcd(_loc6_).compareTo($.C("com.hurlant.math.BigInteger").ONE) == 0 && _loc5_.p.isProbablePrime(10)));
            do
            {
               _loc5_.q = __RSAKey.bigRandom(_loc4_,_loc3_);
            }
            while(!(_loc5_.q.subtract($.C("com.hurlant.math.BigInteger").ONE).gcd(_loc6_).compareTo($.C("com.hurlant.math.BigInteger").ONE) == 0 && _loc5_.q.isProbablePrime(10)));
            if(_loc5_.p.compareTo(_loc5_.q) <= 0)
            {
               _loc10_ = _loc5_.p;
               _loc5_.p = _loc5_.q;
               _loc5_.q = _loc10_;
            }
            _loc7_ = _loc5_.p.subtract($.C("com.hurlant.math.BigInteger").ONE);
            _loc8_ = _loc5_.q.subtract($.C("com.hurlant.math.BigInteger").ONE);
         }
         while(_loc9_ = _loc7_.multiply(_loc8_), _loc9_.gcd(_loc6_).compareTo($.C("com.hurlant.math.BigInteger").ONE) != 0);
         _loc5_.n = _loc5_.p.multiply(_loc5_.q);
         _loc5_.d = _loc6_.modInverse(_loc9_);
         _loc5_.dmp1 = _loc5_.d.mod(_loc7_);
         _loc5_.dmq1 = _loc5_.d.mod(_loc8_);
         _loc5_.coeff = _loc5_.q.modInverse(_loc5_.p);
         return _loc5_;
      }
    static parsePrivateKey(param1, param2, param3, param4 = null, param5 = null, param6 = null, param7 = null, param8 = null) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if (param5 != null && typeof param5 !== "string") param5 = String(param5);
         if (param6 != null && typeof param6 !== "string") param6 = String(param6);
         if (param7 != null && typeof param7 !== "string") param7 = String(param7);
         if (param8 != null && typeof param8 !== "string") param8 = String(param8);
         if(param4 == null)
         {
            return new (__RSAKey)(new ($.C("com.hurlant.math.BigInteger"))(param1,16),parseInt(param2,16),new ($.C("com.hurlant.math.BigInteger"))(param3,16));
         }
         return new (__RSAKey)(new ($.C("com.hurlant.math.BigInteger"))(param1,16),parseInt(param2,16),new ($.C("com.hurlant.math.BigInteger"))(param3,16),new ($.C("com.hurlant.math.BigInteger"))(param4,16),new ($.C("com.hurlant.math.BigInteger"))(param5,16),new ($.C("com.hurlant.math.BigInteger"))(param6,16),new ($.C("com.hurlant.math.BigInteger"))(param7),new ($.C("com.hurlant.math.BigInteger"))(param8));
      }
    verify(param1, param2, param3, param4 = null) {
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         this._decrypt($.bind(this, "doPublic"),param1,param2,param3,param4,1);
      }
    dump() {
         var _loc1_ = null;
         _loc1_ = "N=" + this.n.toString(16) + "\n" + "E=" + this.e.toString(16) + "\n";
         if(this.canDecrypt)
         {
            _loc1_ += "D=" + this.d.toString(16) + "\n";
            if(this.p != null && this.q != null)
            {
               _loc1_ += "P=" + this.p.toString(16) + "\n";
               _loc1_ += "Q=" + this.q.toString(16) + "\n";
               _loc1_ += "DMP1=" + this.dmp1.toString(16) + "\n";
               _loc1_ += "DMQ1=" + this.dmq1.toString(16) + "\n";
               _loc1_ += "IQMP=" + this.coeff.toString(16) + "\n";
            }
         }
         return _loc1_;
      }
    doPrivate2(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         if(this.p == null && this.q == null)
         {
            return param1.modPow(this.d,this.n);
         }
         _loc2_ = param1.mod(this.p).modPow(this.dmp1,this.p);
         _loc3_ = param1.mod(this.q).modPow(this.dmq1,this.q);
         while(_loc2_.compareTo(_loc3_) < 0)
         {
            _loc2_ = _loc2_.add(this.p);
         }
         return _loc2_.subtract(_loc3_).multiply(this.coeff).mod(this.p).multiply(this.q).add(_loc3_);
      }
    decrypt(param1, param2, param3, param4 = null) {
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         this._decrypt($.bind(this, "doPrivate2"),param1,param2,param3,param4,2);
      }
    _decrypt(param1, param2, param3, param4, param5, param6) {
         if (typeof param4 !== "number" || param4 < 0 || (param4 >>> 0) !== param4) param4 = $.uint(param4);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc9_ = null;
         var _loc10_ = null;
         var _loc11_ = null;
         if(param5 == null)
         {
            param5 = $.bind(this, "pkcs1unpad");
         }
         if(param2.position >= param2.length)
         {
            param2.position = 0;
         }
         _loc7_ = this.getBlockSize();
         _loc8_ = param2.position + param4;
         while(param2.position < _loc8_)
         {
            _loc9_ = new ($.C("com.hurlant.math.BigInteger"))(param2,param4);
            _loc10_ = param1(_loc9_);
            _loc11_ = param5(_loc10_,_loc7_);
            param3.writeBytes(_loc11_);
         }
      }
    doPublic(param1) {
         return param1.modPowInt(this.e,this.n);
      }
    dispose() {
         this.e = 0;
         this.n.dispose();
         this.n = null;
         $.C("com.hurlant.util.Memory").gc();
      }
    _encrypt(param1, param2, param3, param4, param5, param6) {
         if (typeof param4 !== "number" || param4 < 0 || (param4 >>> 0) !== param4) param4 = $.uint(param4);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc9_ = null;
         var _loc10_ = null;
         if(param5 == null)
         {
            param5 = $.bind(this, "pkcs1pad");
         }
         if(param2.position >= param2.length)
         {
            param2.position = 0;
         }
         _loc7_ = this.getBlockSize();
         _loc8_ = param2.position + param4;
         while(param2.position < _loc8_)
         {
            _loc9_ = new ($.C("com.hurlant.math.BigInteger"))(param5(param2,_loc8_,_loc7_,param6),_loc7_);
            _loc10_ = param1(_loc9_);
            _loc10_.toArray(param3);
         }
      }
    rawpad(param1, param2, param3) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         return param1;
      }
    encrypt(param1, param2, param3, param4 = null) {
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         this._encrypt($.bind(this, "doPublic"),param1,param2,param3,param4,2);
      }
    pkcs1pad(param1, param2, param3, param4 = 2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         if (typeof param4 !== "number" || param4 < 0 || (param4 >>> 0) !== param4) param4 = $.uint(param4);
         var _loc5_ = null;
         var _loc6_ = 0;
         var _loc7_ = 0;
         var _loc8_ = null;
         var _loc9_ = 0;
         _loc5_ = new ($.C("flash.utils.ByteArray"))();
         _loc6_ = param1.position;
         param2 = Math.min(param2,param1.length,_loc6_ + param3 - 11);
         param1.position = param2;
         _loc7_ = $.int(param2 - 1);
         while(_loc7_ >= _loc6_ && param3 > 11)
         {
            var _loc10_;
            _loc5_[_loc10_ = --param3] = param1[_loc7_--];
         }
         _loc5_[_loc10_ = --param3] = 0;
         _loc8_ = new ($.C("com.hurlant.crypto.prng.Random"))();
         while(param3 > 2)
         {
            _loc9_ = 0;
            while(_loc9_ == 0)
            {
               _loc9_ = param4 == 2 ? _loc8_.nextByte() : 255;
            }
            var _loc11_;
            _loc5_[_loc11_ = --param3] = _loc9_;
         }
         _loc5_[_loc11_ = --param3] = param4;
         var _loc12_;
         _loc5_[_loc12_ = --param3] = 0;
         return _loc5_;
      }
    pkcs1unpad(param1, param2, param3 = 2) {
         if (typeof param2 !== "number" || param2 < 0 || (param2 >>> 0) !== param2) param2 = $.uint(param2);
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = 0;
         _loc4_ = param1.toByteArray();
         _loc5_ = new ($.C("flash.utils.ByteArray"))();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length && _loc4_[_loc6_] == 0)
         {
            _loc6_++;
         }
         if(_loc4_.length - _loc6_ != param2 - 1 || _loc4_[_loc6_] > 2)
         {
            $.trace("PKCS#1 unpad: i=" + _loc6_ + ", expected b[i]==[0,1,2], got b[i]=" + _loc4_[_loc6_].toString(16));
            return null;
         }
         _loc6_++;
         while(_loc4_[_loc6_] != 0)
         {
            if(++_loc6_ >= _loc4_.length)
            {
               $.trace("PKCS#1 unpad: i=" + _loc6_ + ", b[i-1]!=0 (=" + _loc4_[_loc6_ - 1].toString(16) + ")");
               return null;
            }
         }
         while(++_loc6_ < _loc4_.length)
         {
            _loc5_.writeByte(_loc4_[_loc6_]);
         }
         _loc5_.position = 0;
         return _loc5_;
      }
    getBlockSize() {
         return (this.n.bitLength() + 7) / 8;
      }
    toString() {
         return "rsa";
      }
    sign(param1, param2, param3, param4 = null) {
         if (typeof param3 !== "number" || param3 < 0 || (param3 >>> 0) !== param3) param3 = $.uint(param3);
         this._encrypt($.bind(this, "doPrivate2"),param1,param2,param3,param4,1);
      }
    doPrivate(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         if(this.p == null || this.q == null)
         {
            return param1.modPow(this.d,this.n);
         }
         _loc2_ = param1.mod(this.p).modPow(this.dmp1,this.p);
         _loc3_ = param1.mod(this.q).modPow(this.dmq1,this.q);
         while(_loc2_.compareTo(_loc3_) < 0)
         {
            _loc2_ = _loc2_.add(this.p);
         }
         return _loc2_.subtract(_loc3_).multiply(this.coeff).mod(this.p).multiply(this.q).add(_loc3_);
      }
  }
  $.meta(__RSAKey, "com.hurlant.crypto.rsa.RSAKey", []);
  return __RSAKey;
}
deps["com.hurlant.crypto.rsa.RSAKey"] = ["com.hurlant.crypto.prng.Random", "com.hurlant.math.BigInteger", "com.hurlant.util.Memory", "flash.utils.ByteArray"];

defs["com.hurlant.crypto.symmetric.ICipher"] = function define($) {
  return $.interface("com.hurlant.crypto.symmetric.ICipher", []);
}

defs["com.hurlant.crypto.symmetric.IStreamCipher"] = function define($) {
  return $.interface("com.hurlant.crypto.symmetric.IStreamCipher", ["ICipher"]);
}

defs["com.hurlant.math.BarrettReduction"] = function define($) {
  const __Base = $.Object;
  class __BarrettReduction extends __Base {
    static $fields(self) {
    self.r2 = null;
    self.q3 = null;
    self.mu = null;
    self.m = null;
    }
    constructor(param1) {
         super();
         this.r2 = new ($.C("com.hurlant.math.BigInteger"))();
         this.q3 = new ($.C("com.hurlant.math.BigInteger"))();
         $.C("com.hurlant.math.BigInteger").ONE.dlShiftTo(2 * param1.t,this.r2);
         this.mu = this.r2.divide(param1);
         this.m = param1;
      }
    reduce(param1) {
         var _loc2_ = null;
         _loc2_ = $.as(param1, $.C("com.hurlant.math.BigInteger"));
         _loc2_.drShiftTo(this.m.t - 1,this.r2);
         if(_loc2_.t > this.m.t + 1)
         {
            _loc2_.t = this.m.t + 1;
            _loc2_.clamp();
         }
         this.mu.multiplyUpperTo(this.r2,this.m.t + 1,this.q3);
         this.m.multiplyLowerTo(this.q3,this.m.t + 1,this.r2);
         while(_loc2_.compareTo(this.r2) < 0)
         {
            _loc2_.dAddOffset(1,this.m.t + 1);
         }
         _loc2_.subTo(this.r2,_loc2_);
         while(_loc2_.compareTo(this.m) >= 0)
         {
            _loc2_.subTo(this.m,_loc2_);
         }
      }
    revert(param1) {
         return param1;
      }
    convert(param1) {
         var _loc2_ = null;
         if(param1.s < 0 || param1.t > 2 * this.m.t)
         {
            return param1.mod(this.m);
         }
         if(param1.compareTo(this.m) < 0)
         {
            return param1;
         }
         _loc2_ = new ($.C("com.hurlant.math.BigInteger"))();
         param1.copyTo(_loc2_);
         this.reduce(_loc2_);
         return _loc2_;
      }
    sqrTo(param1, param2) {
         param1.squareTo(param2);
         this.reduce(param2);
      }
    mulTo(param1, param2, param3) {
         param1.multiplyTo(param2,param3);
         this.reduce(param3);
      }
  }
  $.meta(__BarrettReduction, "com.hurlant.math.BarrettReduction", ["IReduction"]);
  return __BarrettReduction;
}
deps["com.hurlant.math.BarrettReduction"] = ["com.hurlant.math.BigInteger"];

defs["com.hurlant.math.BigInteger"] = function define($) {
  const __Base = $.Object;
  class __BigInteger extends __Base {
    static $fields(self) {
    self.a = null;
    self.s = 0;
    self.t = 0;
    }
    constructor(param1 = null, param2 = 0) {
         var _loc3_ = null;
         var _loc4_ = 0;
         super();
         this.a = new Array();
         if($.is(param1, "String"))
         {
            param1 = $.C("com.hurlant.util.Hex").toArray(param1);
            param2 = 0;
         }
         if($.is(param1, $.C("flash.utils.ByteArray")))
         {
            _loc3_ = $.as(param1, $.C("flash.utils.ByteArray"));
            _loc4_ = $.int(param2 || $.int(_loc3_.length - _loc3_.position));
            this.fromArray(_loc3_,_loc4_);
         }
      }
    static nbv(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         _loc2_.fromInt(param1);
         return _loc2_;
      }
    clearBit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this.changeBit(param1,$.bind(this, "op_andnot"));
      }
    negate() {
         var _loc1_ = null;
         _loc1_ = this.nbi();
         __BigInteger.ZERO.subTo(this,_loc1_);
         return _loc1_;
      }
    andNot(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.bitwiseTo(param1,$.bind(this, "op_andnot"),_loc2_);
         return _loc2_;
      }
    modPow(param1, param2) {
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc8_ = 0;
         var _loc9_ = 0;
         var _loc10_ = 0;
         var _loc11_ = 0;
         var _loc12_ = 0;
         var _loc13_ = false;
         var _loc14_ = null;
         var _loc15_ = null;
         var _loc16_ = null;
         _loc3_ = param1.bitLength();
         _loc5_ = __BigInteger.nbv(1);
         if(_loc3_ <= 0)
         {
            return _loc5_;
         }
         if(_loc3_ < 18)
         {
            _loc4_ = 1;
         }
         else if(_loc3_ < 48)
         {
            _loc4_ = 3;
         }
         else if(_loc3_ < 144)
         {
            _loc4_ = 4;
         }
         else if(_loc3_ < 768)
         {
            _loc4_ = 5;
         }
         else
         {
            _loc4_ = 6;
         }
         if(_loc3_ < 8)
         {
            _loc6_ = new ($.C("com.hurlant.math.ClassicReduction"))(param2);
         }
         else if(param2.isEven())
         {
            _loc6_ = new ($.C("com.hurlant.math.BarrettReduction"))(param2);
         }
         else
         {
            _loc6_ = new ($.C("com.hurlant.math.MontgomeryReduction"))(param2);
         }
         _loc7_ = [];
         _loc8_ = 3;
         _loc9_ = _loc4_ - 1;
         _loc10_ = (1 << _loc4_) - 1;
         _loc7_[1] = _loc6_.convert(this);
         if(_loc4_ > 1)
         {
            _loc16_ = new (__BigInteger)();
            _loc6_.sqrTo(_loc7_[1],_loc16_);
            while(_loc8_ <= _loc10_)
            {
               _loc7_[_loc8_] = new (__BigInteger)();
               _loc6_.mulTo(_loc16_,_loc7_[_loc8_ - 2],_loc7_[_loc8_]);
               _loc8_ += 2;
            }
         }
         _loc11_ = $.int(param1.t - 1);
         _loc13_ = true;
         _loc14_ = new (__BigInteger)();
         _loc3_ = this.nbits(param1.a[_loc11_]) - 1;
         while(_loc11_ >= 0)
         {
            if(_loc3_ >= _loc9_)
            {
               _loc12_ = param1.a[_loc11_] >> _loc3_ - _loc9_ & _loc10_;
            }
            else
            {
               _loc12_ = (param1.a[_loc11_] & (1 << _loc3_ + 1) - 1) << _loc9_ - _loc3_;
               if(_loc11_ > 0)
               {
                  _loc12_ |= param1.a[_loc11_ - 1] >> __BigInteger.DB + _loc3_ - _loc9_;
               }
            }
            _loc8_ = _loc4_;
            while((_loc12_ & 1) == 0)
            {
               _loc12_ >>= 1;
               _loc8_--;
            }
            _loc3_ = _loc3_ - _loc8_;
            if(_loc3_ < 0)
            {
               _loc3_ += __BigInteger.DB;
               _loc11_--;
            }
            if(_loc13_)
            {
               _loc7_[_loc12_].copyTo(_loc5_);
               _loc13_ = false;
            }
            else
            {
               while(_loc8_ > 1)
               {
                  _loc6_.sqrTo(_loc5_,_loc14_);
                  _loc6_.sqrTo(_loc14_,_loc5_);
                  _loc8_ -= 2;
               }
               if(_loc8_ > 0)
               {
                  _loc6_.sqrTo(_loc5_,_loc14_);
               }
               else
               {
                  _loc15_ = _loc5_;
                  _loc5_ = _loc14_;
                  _loc14_ = _loc15_;
               }
               _loc6_.mulTo(_loc14_,_loc7_[_loc12_],_loc5_);
            }
            while(_loc11_ >= 0 && (param1.a[_loc11_] & 1 << _loc3_) == 0)
            {
               _loc6_.sqrTo(_loc5_,_loc14_);
               _loc15_ = _loc5_;
               _loc5_ = _loc14_;
               _loc14_ = _loc15_;
               if(--_loc3_ < 0)
               {
                  _loc3_ = __BigInteger.DB - 1;
                  _loc11_--;
               }
            }
         }
         return _loc6_.revert(_loc5_);
      }
    isProbablePrime(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = 0;
         _loc3_ = this.abs();
         if(_loc3_.t == 1 && _loc3_.a[0] <= __BigInteger.lowprimes[__BigInteger.lowprimes.length - 1])
         {
            _loc2_ = 0;
            while(_loc2_ < __BigInteger.lowprimes.length)
            {
               if(_loc3_[0] == __BigInteger.lowprimes[_loc2_])
               {
                  return true;
               }
               _loc2_++;
            }
            return false;
         }
         if(_loc3_.isEven())
         {
            return false;
         }
         _loc2_ = 1;
         loop1:
         while(_loc2_ < __BigInteger.lowprimes.length)
         {
            _loc4_ = $.int(__BigInteger.lowprimes[_loc2_]);
            _loc5_ = $.int(_loc2_ + 1);
            while(_loc5_ < __BigInteger.lowprimes.length && _loc4_ < __BigInteger.lplim)
            {
               _loc4_ *= __BigInteger.lowprimes[_loc5_++];
            }
            _loc4_ = _loc3_.modInt(_loc4_);
            do
            {
               if(_loc2_ >= _loc5_)
               {
                  continue loop1;
               }
            }
            while(_loc4_ % __BigInteger.lowprimes[_loc2_++] != 0);
            return false;
         }
         return _loc3_.millerRabin(param1);
      }
    op_or(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return param1 | param2;
      }
    mod(param1) {
         var _loc2_ = null;
         _loc2_ = this.nbi();
         this.abs().divRemTo(param1,null,_loc2_);
         if(this.s < 0 && _loc2_.compareTo(__BigInteger.ZERO) > 0)
         {
            param1.subTo(_loc2_,_loc2_);
         }
         return _loc2_;
      }
    addTo(param1, param2) {
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = Math.min(param1.t,this.t);
         while(_loc3_ < _loc5_)
         {
            _loc4_ += this.a[_loc3_] + param1.a[_loc3_];
            var _loc6_;
            param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
            _loc4_ >>= __BigInteger.DB;
         }
         if(param1.t < this.t)
         {
            _loc4_ += param1.s;
            while(_loc3_ < this.t)
            {
               _loc4_ += this.a[_loc3_];
               param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
               _loc4_ >>= __BigInteger.DB;
            }
            _loc4_ += this.s;
         }
         else
         {
            _loc4_ += this.s;
            while(_loc3_ < param1.t)
            {
               _loc4_ += param1.a[_loc3_];
               param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
               _loc4_ >>= __BigInteger.DB;
            }
            _loc4_ += param1.s;
         }
         param2.s = _loc4_ < 0 ? -1 : 0;
         if(_loc4_ > 0)
         {
            param2.a[_loc6_ = _loc3_++] = _loc4_;
         }
         else if(_loc4_ < -1)
         {
            param2.a[_loc6_ = _loc3_++] = __BigInteger.DV + _loc4_;
         }
         param2.t = _loc3_;
         param2.clamp();
      }
    bitwiseTo(param1, param2, param3) {
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         _loc6_ = Math.min(param1.t,this.t);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            param3.a[_loc4_] = param2(this.a[_loc4_],param1.a[_loc4_]);
            _loc4_++;
         }
         if(param1.t < this.t)
         {
            _loc5_ = param1.s & __BigInteger.DM;
            _loc4_ = _loc6_;
            while(_loc4_ < this.t)
            {
               param3.a[_loc4_] = param2(this.a[_loc4_],_loc5_);
               _loc4_++;
            }
            param3.t = this.t;
         }
         else
         {
            _loc5_ = this.s & __BigInteger.DM;
            _loc4_ = _loc6_;
            while(_loc4_ < param1.t)
            {
               param3.a[_loc4_] = param2(_loc5_,param1.a[_loc4_]);
               _loc4_++;
            }
            param3.t = param1.t;
         }
         param3.s = param2(this.s,param1.s);
         param3.clamp();
      }
    modInt(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = 0;
         if(param1 <= 0)
         {
            return 0;
         }
         _loc2_ = __BigInteger.DV % param1;
         _loc3_ = this.s < 0 ? $.int(param1 - 1) : 0;
         if(this.t > 0)
         {
            if(_loc2_ == 0)
            {
               _loc3_ = this.a[0] % param1;
            }
            else
            {
               _loc4_ = $.int(this.t - 1);
               while(_loc4_ >= 0)
               {
                  _loc3_ = (_loc2_ * _loc3_ + this.a[_loc4_]) % param1;
                  _loc4_--;
               }
            }
         }
         return _loc3_;
      }
    chunkSize(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         return Math.floor(Math.LN2 * __BigInteger.DB / Math.log(param1));
      }
    dAddOffset(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         while(this.t <= param2)
         {
            this.a[this.t++] = 0;
         }
         this.a[param2] += param1;
         while(this.a[param2] >= __BigInteger.DV)
         {
            this.a[param2] -= __BigInteger.DV;
            if(++param2 >= this.t)
            {
               this.a[this.t++] = 0;
            }
            ++this.a[param2];
         }
      }
    lShiftTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = 0;
         var _loc8_ = 0;
         _loc3_ = param1 % __BigInteger.DB;
         _loc4_ = __BigInteger.DB - _loc3_;
         _loc5_ = (1 << _loc4_) - 1;
         _loc6_ = param1 / __BigInteger.DB;
         _loc7_ = this.s << _loc3_ & __BigInteger.DM;
         _loc8_ = $.int(this.t - 1);
         while(_loc8_ >= 0)
         {
            param2.a[_loc8_ + _loc6_ + 1] = this.a[_loc8_] >> _loc4_ | _loc7_;
            _loc7_ = (this.a[_loc8_] & _loc5_) << _loc3_;
            _loc8_--;
         }
         _loc8_ = $.int(_loc6_ - 1);
         while(_loc8_ >= 0)
         {
            param2.a[_loc8_] = 0;
            _loc8_--;
         }
         param2.a[_loc6_] = _loc7_;
         param2.t = this.t + _loc6_ + 1;
         param2.s = this.s;
         param2.clamp();
      }
    getLowestSetBit() {
         var _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.t)
         {
            if(this.a[_loc1_] != 0)
            {
               return _loc1_ * __BigInteger.DB + this.lbit(this.a[_loc1_]);
            }
            _loc1_++;
         }
         if(this.s < 0)
         {
            return this.t * __BigInteger.DB;
         }
         return -1;
      }
    subtract(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.subTo(param1,_loc2_);
         return _loc2_;
      }
    primify(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(!this.testBit(param1 - 1))
         {
            this.bitwiseTo(__BigInteger.ONE.shiftLeft(param1 - 1),$.bind(this, "op_or"),this);
         }
         if(this.isEven())
         {
            this.dAddOffset(1,0);
         }
         while(!this.isProbablePrime(param2))
         {
            this.dAddOffset(2,0);
            while(this.bitLength() > param1)
            {
               this.subTo(__BigInteger.ONE.shiftLeft(param1 - 1),this);
            }
         }
      }
    gcd(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = null;
         _loc2_ = this.s < 0 ? this.negate() : this.clone();
         _loc3_ = param1.s < 0 ? param1.negate() : param1.clone();
         if(_loc2_.compareTo(_loc3_) < 0)
         {
            _loc6_ = _loc2_;
            _loc2_ = _loc3_;
            _loc3_ = _loc6_;
         }
         _loc4_ = _loc2_.getLowestSetBit();
         _loc5_ = _loc3_.getLowestSetBit();
         if(_loc5_ < 0)
         {
            return _loc2_;
         }
         if(_loc4_ < _loc5_)
         {
            _loc5_ = _loc4_;
         }
         if(_loc5_ > 0)
         {
            _loc2_.rShiftTo(_loc5_,_loc2_);
            _loc3_.rShiftTo(_loc5_,_loc3_);
         }
         while(_loc2_.sigNum() > 0)
         {
            _loc4_ = _loc2_.getLowestSetBit();
            if(_loc4_ > 0)
            {
               _loc2_.rShiftTo(_loc4_,_loc2_);
            }
            _loc4_ = _loc3_.getLowestSetBit();
            if(_loc4_ > 0)
            {
               _loc3_.rShiftTo(_loc4_,_loc3_);
            }
            if(_loc2_.compareTo(_loc3_) >= 0)
            {
               _loc2_.subTo(_loc3_,_loc2_);
               _loc2_.rShiftTo(1,_loc2_);
            }
            else
            {
               _loc3_.subTo(_loc2_,_loc3_);
               _loc3_.rShiftTo(1,_loc3_);
            }
         }
         if(_loc5_ > 0)
         {
            _loc3_.lShiftTo(_loc5_,_loc3_);
         }
         return _loc3_;
      }
    multiplyLowerTo(param1, param2, param3) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         var _loc5_ = 0;
         _loc4_ = $.int(Math.min(this.t + param1.t,param2));
         param3.s = 0;
         param3.t = _loc4_;
         while(_loc4_ > 0)
         {
            var _loc6_;
            param3.a[_loc6_ = --_loc4_] = 0;
         }
         _loc5_ = param3.t - this.t;
         while(_loc4_ < _loc5_)
         {
            param3.a[_loc4_ + this.t] = this.am(0,param1.a[_loc4_],param3,_loc4_,0,this.t);
            _loc4_++;
         }
         _loc5_ = Math.min(param1.t,param2);
         while(_loc4_ < _loc5_)
         {
            this.am(0,param1.a[_loc4_],param3,_loc4_,0,param2 - _loc4_);
            _loc4_++;
         }
         param3.clamp();
      }
    modPowInt(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         if(param1 < 256 || param2.isEven())
         {
            _loc3_ = new ($.C("com.hurlant.math.ClassicReduction"))(param2);
         }
         else
         {
            _loc3_ = new ($.C("com.hurlant.math.MontgomeryReduction"))(param2);
         }
         return this.exp(param1,_loc3_);
      }
    intAt(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return parseInt(param1.charAt(param2),36);
      }
    testBit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         _loc2_ = Math.floor(param1 / __BigInteger.DB);
         if(_loc2_ >= this.t)
         {
            return this.s != 0;
         }
         return (this.a[_loc2_] & 1 << param1 % __BigInteger.DB) != 0;
      }
    exp(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = 0;
         var _loc7_ = null;
         if(param1 > 4294967295 || param1 < 1)
         {
            return __BigInteger.ONE;
         }
         _loc3_ = this.nbi();
         _loc4_ = this.nbi();
         _loc5_ = param2.convert(this);
         _loc6_ = this.nbits(param1) - 1;
         _loc5_.copyTo(_loc3_);
         while(--_loc6_ >= 0)
         {
            param2.sqrTo(_loc3_,_loc4_);
            if((param1 & 1 << _loc6_) > 0)
            {
               param2.mulTo(_loc4_,_loc5_,_loc3_);
            }
            else
            {
               _loc7_ = _loc3_;
               _loc3_ = _loc4_;
               _loc4_ = _loc7_;
            }
         }
         return param2.revert(_loc3_);
      }
    toArray(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = false;
         var _loc8_ = 0;
         _loc2_ = 8;
         _loc3_ = (1 << 8) - 1;
         _loc4_ = 0;
         _loc5_ = this.t;
         _loc6_ = __BigInteger.DB - _loc5_ * __BigInteger.DB % _loc2_;
         _loc7_ = false;
         _loc8_ = 0;
         if(_loc5_-- > 0)
         {
            if(_loc6_ < __BigInteger.DB && (_loc4_ = this.a[_loc5_] >> _loc6_) > 0)
            {
               _loc7_ = true;
               param1.writeByte(_loc4_);
               _loc8_++;
            }
            while(_loc5_ >= 0)
            {
               if(_loc6_ < _loc2_)
               {
                  _loc4_ = (this.a[_loc5_] & (1 << _loc6_) - 1) << _loc2_ - _loc6_;
                  _loc4_ = _loc4_ | this.a[--_loc5_] >> (_loc6_ = _loc6_ + (__BigInteger.DB - _loc2_));
               }
               else
               {
                  _loc4_ = this.a[_loc5_] >> (_loc6_ = _loc6_ - _loc2_) & _loc3_;
                  if(_loc6_ <= 0)
                  {
                     _loc6_ += __BigInteger.DB;
                     _loc5_--;
                  }
               }
               if(_loc4_ > 0)
               {
                  _loc7_ = true;
               }
               if(_loc7_)
               {
                  param1.writeByte(_loc4_);
                  _loc8_++;
               }
            }
         }
         return _loc8_;
      }
    dispose() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc1_ = new ($.C("com.hurlant.crypto.prng.Random"))();
         _loc2_ = 0;
         while(_loc2_ < this.a.length)
         {
            this.a[_loc2_] = _loc1_.nextByte();
            delete this.a[_loc2_];
            _loc2_++;
         }
         this.a = null;
         this.t = 0;
         this.s = 0;
         $.C("com.hurlant.util.Memory").gc();
      }
    lbit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(param1 == 0)
         {
            return -1;
         }
         _loc2_ = 0;
         if((param1 & 0xFFFF) == 0)
         {
            param1 >>= 16;
            _loc2_ += 16;
         }
         if((param1 & 0xFF) == 0)
         {
            param1 >>= 8;
            _loc2_ += 8;
         }
         if((param1 & 0x0F) == 0)
         {
            param1 >>= 4;
            _loc2_ += 4;
         }
         if((param1 & 3) == 0)
         {
            param1 >>= 2;
            _loc2_ += 2;
         }
         if((param1 & 1) == 0)
         {
            _loc2_++;
         }
         return _loc2_;
      }
    divRemTo(param1, param2 = null, param3 = null) {
         var pm = null;
         var pt = null;
         var y = null;
         var ts = 0;
         var ms = 0;
         var nsh = 0;
         var ys = 0;
         var y0 = 0;
         var yt = NaN;
         var d1 = NaN;
         var d2 = NaN;
         var e = NaN;
         var i = 0;
         var j = 0;
         var t = null;
         var qd = 0;
         var m = param1;
         var q = param2;
         var r = param3;
         pm = m.abs();
         if(pm.t <= 0)
         {
            return;
         }
         pt = this.abs();
         if(pt.t < pm.t)
         {
            if(q != null)
            {
               q.fromInt(0);
            }
            if(r != null)
            {
               this.copyTo(r);
            }
            return;
         }
         if(r == null)
         {
            r = this.nbi();
         }
         y = this.nbi();
         ts = this.s;
         ms = m.s;
         nsh = __BigInteger.DB - this.nbits(pm.a[pm.t - 1]);
         if(nsh > 0)
         {
            pm.lShiftTo(nsh,y);
            pt.lShiftTo(nsh,r);
         }
         else
         {
            pm.copyTo(y);
            pt.copyTo(r);
         }
         ys = y.t;
         y0 = $.int(y.a[ys - 1]);
         if(y0 == 0)
         {
            return;
         }
         yt = y0 * (1 << __BigInteger.F1) + (ys > 1 ? y.a[ys - 2] >> __BigInteger.F2 : 0);
         d1 = __BigInteger.FV / yt;
         d2 = (1 << __BigInteger.F1) / yt;
         e = 1 << __BigInteger.F2;
         i = r.t;
         j = i - ys;
         t = q == null ? this.nbi() : q;
         y.dlShiftTo(j,t);
         if(r.compareTo(t) >= 0)
         {
            var _loc5_;
            r.a[_loc5_ = r.t++] = 1;
            r.subTo(t,r);
         }
         __BigInteger.ONE.dlShiftTo(ys,t);
         t.subTo(y,y);
         while(y.t < ys)
         {
            y.$filter((__x) => (++y.t,!!0));
         }
         while(--j >= 0)
         {
            qd = r.a[--i] == y0 ? __BigInteger.DM : $.int(Number(r.a[i]) * d1 + (Number(r.a[i - 1]) + e) * d2);
            if((r.a[i] = r.a[i] + y.am(0,qd,r,j,0,ys)) < qd)
            {
               y.dlShiftTo(j,t);
               r.subTo(t,r);
               while(r.a[i] < --qd)
               {
                  r.subTo(t,r);
               }
            }
         }
         if(q != null)
         {
            r.drShiftTo(ys,q);
            if(ts != ms)
            {
               __BigInteger.ZERO.subTo(q,q);
            }
         }
         r.t = ys;
         r.clamp();
         if(nsh > 0)
         {
            r.rShiftTo(nsh,r);
         }
         if(ts < 0)
         {
            __BigInteger.ZERO.subTo(r,r);
         }
      }
    remainder(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.divRemTo(param1,null,_loc2_);
         return _loc2_;
      }
    divide(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.divRemTo(param1,_loc2_,null);
         return _loc2_;
      }
    divideAndRemainder(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         _loc2_ = new (__BigInteger)();
         _loc3_ = new (__BigInteger)();
         this.divRemTo(param1,_loc2_,_loc3_);
         return [_loc2_,_loc3_];
      }
    valueOf() {
         var _loc1_ = NaN;
         var _loc2_ = NaN;
         var _loc3_ = 0;
         _loc1_ = 1;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this.t)
         {
            _loc2_ += this.a[_loc3_] * _loc1_;
            _loc1_ *= __BigInteger.DV;
            _loc3_++;
         }
         return _loc2_;
      }
    shiftLeft(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         if(param1 < 0)
         {
            this.rShiftTo(-param1,_loc2_);
         }
         else
         {
            this.lShiftTo(param1,_loc2_);
         }
         return _loc2_;
      }
    multiply(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.multiplyTo(param1,_loc2_);
         return _loc2_;
      }
    am(param1, param2, param3, param4, param5, param6) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc9_ = 0;
         var _loc10_ = 0;
         var _loc11_ = 0;
         _loc7_ = param2 & 0x7FFF;
         _loc8_ = param2 >> 15;
         while(--param6 >= 0)
         {
            _loc9_ = this.a[param1] & 0x7FFF;
            _loc10_ = this.a[param1++] >> 15;
            _loc11_ = _loc8_ * _loc9_ + _loc10_ * _loc7_;
            _loc9_ = _loc7_ * _loc9_ + ((_loc11_ & 0x7FFF) << 15) + param3.a[param4] + (param5 & 0x3FFFFFFF);
            param5 = (_loc9_ >>> 30) + (_loc11_ >>> 15) + _loc8_ * _loc10_ + (param5 >>> 30);
            var _loc12_;
            param3.a[_loc12_ = param4++] = _loc9_ & 0x3FFFFFFF;
         }
         return param5;
      }
    drShiftTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         _loc3_ = param1;
         while(_loc3_ < this.t)
         {
            param2.a[_loc3_ - param1] = this.a[_loc3_];
            _loc3_++;
         }
         param2.t = Math.max(this.t - param1,0);
         param2.s = this.s;
      }
    add(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.addTo(param1,_loc2_);
         return _loc2_;
      }
    multiplyUpperTo(param1, param2, param3) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = 0;
         param2--;
         _loc4_ = param3.t = this.t + param1.t - param2;
         param3.s = 0;
         while(--_loc4_ >= 0)
         {
            param3.a[_loc4_] = 0;
         }
         _loc4_ = $.int(Math.max(param2 - this.t,0));
         while(_loc4_ < param1.t)
         {
            param3.a[this.t + _loc4_ - param2] = this.am(param2 - _loc4_,param1.a[_loc4_],param3,0,0,this.t + _loc4_ - param2);
            _loc4_++;
         }
         param3.clamp();
         param3.drShiftTo(1,param3);
      }
    nbi() {
         return new (__BigInteger)();
      }
    millerRabin(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = 0;
         var _loc7_ = null;
         var _loc8_ = 0;
         _loc2_ = this.subtract(__BigInteger.ONE);
         _loc3_ = _loc2_.getLowestSetBit();
         if(_loc3_ <= 0)
         {
            return false;
         }
         _loc4_ = _loc2_.shiftRight(_loc3_);
         param1 = param1 + 1 >> 1;
         if(param1 > __BigInteger.lowprimes.length)
         {
            param1 = $.int(__BigInteger.lowprimes.length);
         }
         _loc5_ = new (__BigInteger)();
         _loc6_ = 0;
         while(_loc6_ < param1)
         {
            _loc5_.fromInt(__BigInteger.lowprimes[_loc6_]);
            _loc7_ = _loc5_.modPow(_loc4_,this);
            if(_loc7_.compareTo(__BigInteger.ONE) != 0 && _loc7_.compareTo(_loc2_) != 0)
            {
               _loc8_ = 1;
               while(_loc8_++ < _loc3_ && _loc7_.compareTo(_loc2_) != 0)
               {
                  _loc7_ = _loc7_.modPowInt(2,this);
                  if(_loc7_.compareTo(__BigInteger.ONE) == 0)
                  {
                     return false;
                  }
               }
               if(_loc7_.compareTo(_loc2_) != 0)
               {
                  return false;
               }
            }
            _loc6_++;
         }
         return true;
      }
    dMultiply(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.a[this.t] = this.am(0,param1 - 1,this,0,0,this.t);
         ++this.t;
         this.clamp();
      }
    op_andnot(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return param1 & ~param2;
      }
    clamp() {
         var _loc1_ = 0;
         _loc1_ = this.s & __BigInteger.DM;
         while(this.t > 0 && this.a[this.t - 1] == _loc1_)
         {
            --this.t;
         }
      }
    invDigit() {
         var _loc1_ = 0;
         var _loc2_ = 0;
         if(this.t < 1)
         {
            return 0;
         }
         _loc1_ = $.int(this.a[0]);
         if((_loc1_ & 1) == 0)
         {
            return 0;
         }
         _loc2_ = _loc1_ & 3;
         _loc2_ = _loc2_ * (2 - (_loc1_ & 0x0F) * _loc2_) & 0x0F;
         _loc2_ = _loc2_ * (2 - (_loc1_ & 0xFF) * _loc2_) & 0xFF;
         _loc2_ = _loc2_ * (2 - ((_loc1_ & 0xFFFF) * _loc2_ & 0xFFFF)) & 0xFFFF;
         _loc2_ = _loc2_ * (2 - _loc1_ * _loc2_ % __BigInteger.DV) % __BigInteger.DV;
         return _loc2_ > 0 ? $.int(__BigInteger.DV - _loc2_) : $.int(-_loc2_);
      }
    changeBit(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = null;
         _loc3_ = __BigInteger.ONE.shiftLeft(param1);
         this.bitwiseTo(_loc3_,param2,_loc3_);
         return _loc3_;
      }
    equals(param1) {
         return this.compareTo(param1) == 0;
      }
    compareTo(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         _loc2_ = this.s - param1.s;
         if(_loc2_ != 0)
         {
            return _loc2_;
         }
         _loc3_ = this.t;
         _loc2_ = _loc3_ - param1.t;
         if(_loc2_ != 0)
         {
            return _loc2_;
         }
         while(--_loc3_ >= 0)
         {
            _loc2_ = this.a[_loc3_] - param1.a[_loc3_];
            if(_loc2_ != 0)
            {
               return _loc2_;
            }
         }
         return 0;
      }
    shiftRight(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         if(param1 < 0)
         {
            this.lShiftTo(-param1,_loc2_);
         }
         else
         {
            this.rShiftTo(param1,_loc2_);
         }
         return _loc2_;
      }
    multiplyTo(param1, param2) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = 0;
         _loc3_ = this.abs();
         _loc4_ = param1.abs();
         _loc5_ = _loc3_.t;
         param2.t = _loc5_ + _loc4_.t;
         while(--_loc5_ >= 0)
         {
            param2.a[_loc5_] = 0;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.t)
         {
            param2.a[_loc5_ + _loc3_.t] = _loc3_.am(0,_loc4_.a[_loc5_],param2,_loc5_,0,_loc3_.t);
            _loc5_++;
         }
         param2.s = 0;
         param2.clamp();
         if(this.s != param1.s)
         {
            __BigInteger.ZERO.subTo(param2,param2);
         }
      }
    bitCount() {
         var _loc1_ = 0;
         var _loc2_ = 0;
         var _loc3_ = 0;
         _loc1_ = 0;
         _loc2_ = this.s & __BigInteger.DM;
         _loc3_ = 0;
         while(_loc3_ < this.t)
         {
            _loc1_ += this.cbit(this.a[_loc3_] ^ _loc2_);
            _loc3_++;
         }
         return _loc1_;
      }
    byteValue() {
         return this.t == 0 ? this.s : this.a[0] << 24 >> 24;
      }
    cbit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         _loc2_ = 0;
         while(param1 != 0)
         {
            param1 &= param1 - 1;
            _loc2_++;
         }
         return _loc2_;
      }
    rShiftTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = 0;
         param2.s = this.s;
         _loc3_ = param1 / __BigInteger.DB;
         if(_loc3_ >= this.t)
         {
            param2.t = 0;
            return;
         }
         _loc4_ = param1 % __BigInteger.DB;
         _loc5_ = __BigInteger.DB - _loc4_;
         _loc6_ = (1 << _loc4_) - 1;
         param2.a[0] = this.a[_loc3_] >> _loc4_;
         _loc7_ = $.int(_loc3_ + 1);
         while(_loc7_ < this.t)
         {
            param2.a[_loc7_ - _loc3_ - 1] |= (this.a[_loc7_] & _loc6_) << _loc5_;
            param2.a[_loc7_ - _loc3_] = this.a[_loc7_] >> _loc4_;
            _loc7_++;
         }
         if(_loc4_ > 0)
         {
            param2.a[this.t - _loc3_ - 1] |= (this.s & _loc6_) << _loc5_;
         }
         param2.t = this.t - _loc3_;
         param2.clamp();
      }
    modInverse(param1) {
         var _loc2_ = false;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc8_ = null;
         _loc2_ = param1.isEven();
         if(this.isEven() && _loc2_ || param1.sigNum() == 0)
         {
            return __BigInteger.ZERO;
         }
         _loc3_ = param1.clone();
         _loc4_ = this.clone();
         _loc5_ = __BigInteger.nbv(1);
         _loc6_ = __BigInteger.nbv(0);
         _loc7_ = __BigInteger.nbv(0);
         _loc8_ = __BigInteger.nbv(1);
         while(_loc3_.sigNum() != 0)
         {
            while(_loc3_.isEven())
            {
               _loc3_.rShiftTo(1,_loc3_);
               if(_loc2_)
               {
                  if(!_loc5_.isEven() || !_loc6_.isEven())
                  {
                     _loc5_.addTo(this,_loc5_);
                     _loc6_.subTo(param1,_loc6_);
                  }
                  _loc5_.rShiftTo(1,_loc5_);
               }
               else if(!_loc6_.isEven())
               {
                  _loc6_.subTo(param1,_loc6_);
               }
               _loc6_.rShiftTo(1,_loc6_);
            }
            while(_loc4_.isEven())
            {
               _loc4_.rShiftTo(1,_loc4_);
               if(_loc2_)
               {
                  if(!_loc7_.isEven() || !_loc8_.isEven())
                  {
                     _loc7_.addTo(this,_loc7_);
                     _loc8_.subTo(param1,_loc8_);
                  }
                  _loc7_.rShiftTo(1,_loc7_);
               }
               else if(!_loc8_.isEven())
               {
                  _loc8_.subTo(param1,_loc8_);
               }
               _loc8_.rShiftTo(1,_loc8_);
            }
            if(_loc3_.compareTo(_loc4_) >= 0)
            {
               _loc3_.subTo(_loc4_,_loc3_);
               if(_loc2_)
               {
                  _loc5_.subTo(_loc7_,_loc5_);
               }
               _loc6_.subTo(_loc8_,_loc6_);
            }
            else
            {
               _loc4_.subTo(_loc3_,_loc4_);
               if(_loc2_)
               {
                  _loc7_.subTo(_loc5_,_loc7_);
               }
               _loc8_.subTo(_loc6_,_loc8_);
            }
         }
         if(_loc4_.compareTo(__BigInteger.ONE) != 0)
         {
            return __BigInteger.ZERO;
         }
         if(_loc8_.compareTo(param1) >= 0)
         {
            return _loc8_.subtract(param1);
         }
         if(_loc8_.sigNum() < 0)
         {
            _loc8_.addTo(param1,_loc8_);
            if(_loc8_.sigNum() < 0)
            {
               return _loc8_.add(param1);
            }
            return _loc8_;
         }
         return _loc8_;
      }
    fromArray(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = 0;
         _loc3_ = $.int(param1.position);
         _loc4_ = _loc3_ + param2;
         _loc5_ = 0;
         _loc6_ = 8;
         this.t = 0;
         this.s = 0;
         while(--_loc4_ >= _loc3_)
         {
            _loc7_ = _loc4_ < param1.length ? $.int(param1[_loc4_]) : 0;
            if(_loc5_ == 0)
            {
               var _loc8_;
               this.a[_loc8_ = this.t++] = _loc7_;
            }
            else if(_loc5_ + _loc6_ > __BigInteger.DB)
            {
               this.a[this.t - 1] |= (_loc7_ & (1 << __BigInteger.DB - _loc5_) - 1) << _loc5_;
               this.a[_loc8_ = this.t++] = _loc7_ >> __BigInteger.DB - _loc5_;
            }
            else
            {
               this.a[this.t - 1] |= _loc7_ << _loc5_;
            }
            _loc5_ += _loc6_;
            if(_loc5_ >= __BigInteger.DB)
            {
               _loc5_ -= __BigInteger.DB;
            }
         }
         this.clamp();
         param1.position = Math.min(_loc3_ + param2,param1.length);
      }
    copyTo(param1) {
         var _loc2_ = 0;
         _loc2_ = $.int(this.t - 1);
         while(_loc2_ >= 0)
         {
            param1.a[_loc2_] = this.a[_loc2_];
            _loc2_--;
         }
         param1.t = this.t;
         param1.s = this.s;
      }
    intValue() {
         if(this.s < 0)
         {
            if(this.t == 1)
            {
               return this.a[0] - __BigInteger.DV;
            }
            if(this.t == 0)
            {
               return -1;
            }
         }
         else
         {
            if(this.t == 1)
            {
               return this.a[0];
            }
            if(this.t == 0)
            {
               return 0;
            }
         }
         return (this.a[1] & (1 << 32 - __BigInteger.DB) - 1) << __BigInteger.DB | this.a[0];
      }
    min(param1) {
         return this.compareTo(param1) < 0 ? this : param1;
      }
    bitLength() {
         if(this.t <= 0)
         {
            return 0;
         }
         return __BigInteger.DB * (this.t - 1) + this.nbits(this.a[this.t - 1] ^ this.s & __BigInteger.DM);
      }
    shortValue() {
         return this.t == 0 ? this.s : this.a[0] << 16 >> 16;
      }
    and(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.bitwiseTo(param1,$.bind(this, "op_and"),_loc2_);
         return _loc2_;
      }
    toRadix(param1 = 10) {
         if (typeof param1 !== "number" || param1 < 0 || (param1 >>> 0) !== param1) param1 = $.uint(param1);
         var _loc2_ = 0;
         var _loc3_ = NaN;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         if(this.sigNum() == 0 || param1 < 2 || param1 > 32)
         {
            return "0";
         }
         _loc2_ = this.chunkSize(param1);
         _loc3_ = Math.pow(param1,_loc2_);
         _loc4_ = __BigInteger.nbv(_loc3_);
         _loc5_ = this.nbi();
         _loc6_ = this.nbi();
         _loc7_ = "";
         this.divRemTo(_loc4_,_loc5_,_loc6_);
         while(_loc5_.sigNum() > 0)
         {
            _loc7_ = (_loc3_ + _loc6_.intValue()).toString(param1).substr(1) + _loc7_;
            _loc5_.divRemTo(_loc4_,_loc5_,_loc6_);
         }
         return _loc6_.intValue().toString(param1) + _loc7_;
      }
    not() {
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc1_ = new (__BigInteger)();
         _loc2_ = 0;
         while(_loc2_ < this.t)
         {
            _loc1_[_loc2_] = __BigInteger.DM & ~this.a[_loc2_];
            _loc2_++;
         }
         _loc1_.t = this.t;
         _loc1_.s = ~this.s;
         return _loc1_;
      }
    subTo(param1, param2) {
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = Math.min(param1.t,this.t);
         while(_loc3_ < _loc5_)
         {
            _loc4_ += this.a[_loc3_] - param1.a[_loc3_];
            var _loc6_;
            param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
            _loc4_ >>= __BigInteger.DB;
         }
         if(param1.t < this.t)
         {
            _loc4_ -= param1.s;
            while(_loc3_ < this.t)
            {
               _loc4_ += this.a[_loc3_];
               param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
               _loc4_ >>= __BigInteger.DB;
            }
            _loc4_ += this.s;
         }
         else
         {
            _loc4_ += this.s;
            while(_loc3_ < param1.t)
            {
               _loc4_ -= param1.a[_loc3_];
               param2.a[_loc6_ = _loc3_++] = _loc4_ & __BigInteger.DM;
               _loc4_ >>= __BigInteger.DB;
            }
            _loc4_ -= param1.s;
         }
         param2.s = _loc4_ < 0 ? -1 : 0;
         if(_loc4_ < -1)
         {
            param2.a[_loc6_ = _loc3_++] = __BigInteger.DV + _loc4_;
         }
         else if(_loc4_ > 0)
         {
            param2.a[_loc6_ = _loc3_++] = _loc4_;
         }
         param2.t = _loc3_;
         param2.clamp();
      }
    clone() {
         var _loc1_ = null;
         _loc1_ = new (__BigInteger)();
         this.copyTo(_loc1_);
         return _loc1_;
      }
    pow(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this.exp(param1,new ($.C("com.hurlant.math.NullReduction"))());
      }
    flipBit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this.changeBit(param1,$.bind(this, "op_xor"));
      }
    xor(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.bitwiseTo(param1,$.bind(this, "op_xor"),_loc2_);
         return _loc2_;
      }
    or(param1) {
         var _loc2_ = null;
         _loc2_ = new (__BigInteger)();
         this.bitwiseTo(param1,$.bind(this, "op_or"),_loc2_);
         return _loc2_;
      }
    max(param1) {
         return this.compareTo(param1) > 0 ? this : param1;
      }
    fromInt(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.t = 1;
         this.s = param1 < 0 ? -1 : 0;
         if(param1 > 0)
         {
            this.a[0] = param1;
         }
         else if(param1 < -1)
         {
            this.a[0] = param1 + __BigInteger.DV;
         }
         else
         {
            this.t = 0;
         }
      }
    isEven() {
         return (this.t > 0 ? this.a[0] & 1 : this.s) == 0;
      }
    toString(param1 = 16) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = false;
         var _loc6_ = null;
         var _loc7_ = 0;
         var _loc8_ = 0;
         if(this.s < 0)
         {
            return "-" + this.negate().toString(param1);
         }
         switch(param1)
         {
            case 2:
               _loc2_ = 1;
               break;
            case 4:
               _loc2_ = 2;
               break;
            case 8:
               _loc2_ = 3;
               break;
            case 16:
               _loc2_ = 4;
               break;
            case 32:
               _loc2_ = 5;
         }
         _loc3_ = (1 << _loc2_) - 1;
         _loc4_ = 0;
         _loc5_ = false;
         _loc6_ = "";
         _loc7_ = this.t;
         _loc8_ = __BigInteger.DB - _loc7_ * __BigInteger.DB % _loc2_;
         if(_loc7_-- > 0)
         {
            if(_loc8_ < __BigInteger.DB && (_loc4_ = this.a[_loc7_] >> _loc8_) > 0)
            {
               _loc5_ = true;
               _loc6_ = _loc4_.toString(36);
            }
            while(_loc7_ >= 0)
            {
               if(_loc8_ < _loc2_)
               {
                  _loc4_ = (this.a[_loc7_] & (1 << _loc8_) - 1) << _loc2_ - _loc8_;
                  _loc4_ = _loc4_ | this.a[--_loc7_] >> (_loc8_ = _loc8_ + (__BigInteger.DB - _loc2_));
               }
               else
               {
                  _loc4_ = this.a[_loc7_] >> (_loc8_ = _loc8_ - _loc2_) & _loc3_;
                  if(_loc8_ <= 0)
                  {
                     _loc8_ += __BigInteger.DB;
                     _loc7_--;
                  }
               }
               if(_loc4_ > 0)
               {
                  _loc5_ = true;
               }
               if(_loc5_)
               {
                  _loc6_ += _loc4_.toString(36);
               }
            }
         }
         return _loc5_ ? _loc6_ : "0";
      }
    setBit(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this.changeBit(param1,$.bind(this, "op_or"));
      }
    abs() {
         return this.s < 0 ? this.negate() : this;
      }
    nbits(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         var _loc3_ = 0;
         _loc2_ = 1;
         _loc3_ = param1 >>> 16;
         if(_loc3_ != 0)
         {
            param1 = _loc3_;
            _loc2_ += 16;
         }
         _loc3_ = param1 >> 8;
         if(_loc3_ != 0)
         {
            param1 = _loc3_;
            _loc2_ += 8;
         }
         _loc3_ = param1 >> 4;
         if(_loc3_ != 0)
         {
            param1 = _loc3_;
            _loc2_ += 4;
         }
         _loc3_ = param1 >> 2;
         if(_loc3_ != 0)
         {
            param1 = _loc3_;
            _loc2_ += 2;
         }
         _loc3_ = param1 >> 1;
         if(_loc3_ != 0)
         {
            param1 = _loc3_;
            _loc2_ += 1;
         }
         return _loc2_;
      }
    sigNum() {
         if(this.s < 0)
         {
            return -1;
         }
         if(this.t <= 0 || this.t == 1 && this.a[0] <= 0)
         {
            return 0;
         }
         return 1;
      }
    toByteArray() {
         var _loc1_ = 0;
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         _loc1_ = this.t;
         _loc2_ = new ($.C("flash.utils.ByteArray"))();
         _loc2_[0] = this.s;
         _loc3_ = __BigInteger.DB - _loc1_ * __BigInteger.DB % 8;
         _loc5_ = 0;
         if(_loc1_-- > 0)
         {
            if(_loc3_ < __BigInteger.DB && (_loc4_ = this.a[_loc1_] >> _loc3_) != (this.s & __BigInteger.DM) >> _loc3_)
            {
               var _loc6_;
               _loc2_[_loc6_ = _loc5_++] = _loc4_ | this.s << __BigInteger.DB - _loc3_;
            }
            while(_loc1_ >= 0)
            {
               if(_loc3_ < 8)
               {
                  _loc4_ = (this.a[_loc1_] & (1 << _loc3_) - 1) << 8 - _loc3_;
                  _loc4_ = _loc4_ | this.a[--_loc1_] >> (_loc3_ = _loc3_ + (__BigInteger.DB - 8));
               }
               else
               {
                  _loc4_ = this.a[_loc1_] >> (_loc3_ = _loc3_ - 8) & 0xFF;
                  if(_loc3_ <= 0)
                  {
                     _loc3_ += __BigInteger.DB;
                     _loc1_--;
                  }
               }
               if((_loc4_ & 0x80) != 0)
               {
                  _loc4_ |= -256;
               }
               if(_loc5_ == 0 && (this.s & 0x80) != (_loc4_ & 0x80))
               {
                  _loc5_++;
               }
               if(_loc5_ > 0 || _loc4_ != this.s)
               {
                  _loc2_[_loc6_ = _loc5_++] = _loc4_;
               }
            }
         }
         return _loc2_;
      }
    squareTo(param1) {
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc4_ = 0;
         _loc2_ = this.abs();
         _loc3_ = param1.t = 2 * _loc2_.t;
         while(--_loc3_ >= 0)
         {
            param1.a[_loc3_] = 0;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.t - 1)
         {
            _loc4_ = _loc2_.am(_loc3_,_loc2_.a[_loc3_],param1,2 * _loc3_,0,1);
            if((param1.a[_loc3_ + _loc2_.t] = param1.a[_loc3_ + _loc2_.t] + _loc2_.am(_loc3_ + 1,2 * _loc2_.a[_loc3_],param1,2 * _loc3_ + 1,_loc4_,_loc2_.t - _loc3_ - 1)) >= __BigInteger.DV)
            {
               param1.a[_loc3_ + _loc2_.t] -= __BigInteger.DV;
               param1.a[_loc3_ + _loc2_.t + 1] = 1;
            }
            _loc3_++;
         }
         if(param1.t > 0)
         {
            param1.a[param1.t - 1] += _loc2_.am(_loc3_,_loc2_.a[_loc3_],param1,2 * _loc3_,0,1);
         }
         param1.s = 0;
         param1.clamp();
      }
    op_and(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return param1 & param2;
      }
    fromRadix(param1, param2 = 10) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = 0;
         var _loc4_ = NaN;
         var _loc5_ = false;
         var _loc6_ = 0;
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc9_ = 0;
         this.fromInt(0);
         _loc3_ = this.chunkSize(param2);
         _loc4_ = Math.pow(param2,_loc3_);
         _loc5_ = false;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            _loc9_ = this.intAt(param1,_loc8_);
            if(_loc9_ < 0)
            {
               if(param1.charAt(_loc8_) == "-" && this.sigNum() == 0)
               {
                  _loc5_ = true;
               }
            }
            else
            {
               _loc7_ = param2 * _loc7_ + _loc9_;
               if(++_loc6_ >= _loc3_)
               {
                  this.dMultiply(_loc4_);
                  this.dAddOffset(_loc7_,0);
                  _loc6_ = 0;
                  _loc7_ = 0;
               }
            }
            _loc8_++;
         }
         if(_loc6_ > 0)
         {
            this.dMultiply(Math.pow(param2,_loc6_));
            this.dAddOffset(_loc7_,0);
         }
         if(_loc5_)
         {
            __BigInteger.ZERO.subTo(this,this);
         }
      }
    dlShiftTo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc3_ = 0;
         _loc3_ = $.int(this.t - 1);
         while(_loc3_ >= 0)
         {
            param2.a[_loc3_ + param1] = this.a[_loc3_];
            _loc3_--;
         }
         _loc3_ = $.int(param1 - 1);
         while(_loc3_ >= 0)
         {
            param2.a[_loc3_] = 0;
            _loc3_--;
         }
         param2.t = this.t + param1;
         param2.s = this.s;
      }
    op_xor(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return param1 ^ param2;
      }
  }
  $.meta(__BigInteger, "com.hurlant.math.BigInteger", []);
  $.statics(__BigInteger, () => {
    __BigInteger.DB = 30;
    __BigInteger.DV = 1 << __BigInteger.DB;
    __BigInteger.DM = __BigInteger.DV - 1;
    __BigInteger.BI_FP = 52;
    __BigInteger.FV = Math.pow(2,__BigInteger.BI_FP);
    __BigInteger.F1 = __BigInteger.BI_FP - __BigInteger.DB;
    __BigInteger.F2 = 2 * __BigInteger.DB - __BigInteger.BI_FP;
    __BigInteger.ZERO = __BigInteger.nbv(0);
    __BigInteger.ONE = __BigInteger.nbv(1);
    __BigInteger.lowprimes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509];
    __BigInteger.lplim = (1 << 26) / __BigInteger.lowprimes[__BigInteger.lowprimes.length - 1];
  });
  return __BigInteger;
}
deps["com.hurlant.math.BigInteger"] = ["com.hurlant.crypto.prng.Random", "com.hurlant.math.BarrettReduction", "com.hurlant.math.ClassicReduction", "com.hurlant.math.MontgomeryReduction", "com.hurlant.math.NullReduction", "com.hurlant.util.Hex", "com.hurlant.util.Memory", "flash.utils.ByteArray"];

defs["com.hurlant.math.ClassicReduction"] = function define($) {
  const __Base = $.Object;
  class __ClassicReduction extends __Base {
    static $fields(self) {
    self.m = null;
    }
    constructor(param1) {
         super();
         this.m = param1;
      }
    revert(param1) {
         return param1;
      }
    reduce(param1) {
         param1.divRemTo(this.m,null,param1);
      }
    convert(param1) {
         if(param1.s < 0 || param1.compareTo(this.m) >= 0)
         {
            return param1.mod(this.m);
         }
         return param1;
      }
    sqrTo(param1, param2) {
         param1.squareTo(param2);
         this.reduce(param2);
      }
    mulTo(param1, param2, param3) {
         param1.multiplyTo(param2,param3);
         this.reduce(param3);
      }
  }
  $.meta(__ClassicReduction, "com.hurlant.math.ClassicReduction", ["IReduction"]);
  return __ClassicReduction;
}
deps["com.hurlant.math.ClassicReduction"] = [];

defs["com.hurlant.math.IReduction"] = function define($) {
  return $.interface("com.hurlant.math.IReduction", []);
}

defs["com.hurlant.math.MontgomeryReduction"] = function define($) {
  const __Base = $.Object;
  class __MontgomeryReduction extends __Base {
    static $fields(self) {
    self.um = 0;
    self.mp = 0;
    self.mph = 0;
    self.mpl = 0;
    self.mt2 = 0;
    self.m = null;
    }
    constructor(param1) {
         super();
         this.m = param1;
         this.mp = param1.invDigit();
         this.mpl = this.mp & 0x7FFF;
         this.mph = this.mp >> 15;
         this.um = (1 << $.C("com.hurlant.math.BigInteger").DB - 15) - 1;
         this.mt2 = 2 * param1.t;
      }
    mulTo(param1, param2, param3) {
         param1.multiplyTo(param2,param3);
         this.reduce(param3);
      }
    revert(param1) {
         var _loc2_ = null;
         _loc2_ = new ($.C("com.hurlant.math.BigInteger"))();
         param1.copyTo(_loc2_);
         this.reduce(_loc2_);
         return _loc2_;
      }
    convert(param1) {
         var _loc2_ = null;
         _loc2_ = new ($.C("com.hurlant.math.BigInteger"))();
         param1.abs().dlShiftTo(this.m.t,_loc2_);
         _loc2_.divRemTo(this.m,null,_loc2_);
         if(param1.s < 0 && _loc2_.compareTo($.C("com.hurlant.math.BigInteger").ZERO) > 0)
         {
            this.m.subTo(_loc2_,_loc2_);
         }
         return _loc2_;
      }
    reduce(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc4_ = 0;
         while(param1.t <= this.mt2)
         {
            var _loc5_;
            param1.a[_loc5_ = param1.t++] = 0;
         }
         _loc2_ = 0;
         while(_loc2_ < this.m.t)
         {
            _loc3_ = param1.a[_loc2_] & 0x7FFF;
            _loc4_ = _loc3_ * this.mpl + ((_loc3_ * this.mph + (param1.a[_loc2_] >> 15) * this.mpl & this.um) << 15) & $.C("com.hurlant.math.BigInteger").DM;
            _loc3_ = _loc2_ + this.m.t;
            param1.a[_loc3_] += this.m.am(0,_loc4_,param1,_loc2_,0,this.m.t);
            while(param1.a[_loc3_] >= $.C("com.hurlant.math.BigInteger").DV)
            {
               param1.a[_loc3_] -= $.C("com.hurlant.math.BigInteger").DV;
               ++param1.a[++_loc3_];
            }
            _loc2_++;
         }
         param1.clamp();
         param1.drShiftTo(this.m.t,param1);
         if(param1.compareTo(this.m) >= 0)
         {
            param1.subTo(this.m,param1);
         }
      }
    sqrTo(param1, param2) {
         param1.squareTo(param2);
         this.reduce(param2);
      }
  }
  $.meta(__MontgomeryReduction, "com.hurlant.math.MontgomeryReduction", ["IReduction"]);
  return __MontgomeryReduction;
}
deps["com.hurlant.math.MontgomeryReduction"] = ["com.hurlant.math.BigInteger"];

defs["com.hurlant.math.NullReduction"] = function define($) {
  const __Base = $.Object;
  class __NullReduction extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    reduce(param1) {
      }
    revert(param1) {
         return param1;
      }
    mulTo(param1, param2, param3) {
         param1.multiplyTo(param2,param3);
      }
    convert(param1) {
         return param1;
      }
    sqrTo(param1, param2) {
         param1.squareTo(param2);
      }
  }
  $.meta(__NullReduction, "com.hurlant.math.NullReduction", ["IReduction"]);
  return __NullReduction;
}
deps["com.hurlant.math.NullReduction"] = [];

defs["com.hurlant.util.Base64"] = function define($) {
  const __Base = $.Object;
  class __Base64 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         throw new Error("Base64 class is static container only");
      }
    static encode(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = null;
         _loc2_ = new ($.C("flash.utils.ByteArray"))();
         _loc2_.writeUTFBytes(param1);
         return __Base64.encodeByteArray(_loc2_);
      }
    static encodeByteArray(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = 0;
         _loc2_ = "";
         _loc4_ = new Array(4);
         param1.position = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc3_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < 3 && param1.bytesAvailable > 0)
            {
               _loc3_[_loc5_] = param1.readUnsignedByte();
               _loc5_++;
            }
            _loc4_[0] = (_loc3_[0] & 0xFC) >> 2;
            _loc4_[1] = (_loc3_[0] & 3) << 4 | _loc3_[1] >> 4;
            _loc4_[2] = (_loc3_[1] & 0x0F) << 2 | _loc3_[2] >> 6;
            _loc4_[3] = _loc3_[2] & 0x3F;
            _loc6_ = _loc3_.length;
            while(_loc6_ < 3)
            {
               _loc4_[_loc6_ + 1] = 64;
               _loc6_++;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc2_ += __Base64.BASE64_CHARS.charAt(_loc4_[_loc7_]);
               _loc7_++;
            }
         }
         return _loc2_;
      }
    static decode(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = null;
         _loc2_ = __Base64.decodeToByteArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
    static decodeToByteArray(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc7_ = 0;
         _loc2_ = new ($.C("flash.utils.ByteArray"))();
         _loc3_ = new Array(4);
         _loc4_ = new Array(3);
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = 0;
            while(_loc6_ < 4 && _loc5_ + _loc6_ < param1.length)
            {
               _loc3_[_loc6_] = __Base64.BASE64_CHARS.indexOf(param1.charAt(_loc5_ + _loc6_));
               _loc6_++;
            }
            _loc4_[0] = (_loc3_[0] << 2) + ((_loc3_[1] & 0x30) >> 4);
            _loc4_[1] = ((_loc3_[1] & 0x0F) << 4) + ((_loc3_[2] & 0x3C) >> 2);
            _loc4_[2] = ((_loc3_[2] & 3) << 6) + _loc3_[3];
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               if(_loc3_[_loc7_ + 1] == 64)
               {
                  break;
               }
               _loc2_.writeByte(_loc4_[_loc7_]);
               _loc7_++;
            }
            _loc5_ += 4;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
  }
  $.meta(__Base64, "com.hurlant.util.Base64", []);
  $.statics(__Base64, () => {
    __Base64.BASE64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    __Base64.version = "1.0.0";
  });
  return __Base64;
}
deps["com.hurlant.util.Base64"] = ["flash.utils.ByteArray"];

defs["com.hurlant.util.Hex"] = function define($) {
  const __Base = $.Object;
  class __Hex extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static toArray(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         param1 = param1.replace(/\s|:/gm,"");
         var _loc2_ = new ($.C("flash.utils.ByteArray"))();
         if(param1.length & 1 == 1)
         {
            param1 = "0" + param1;
         }
         var _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_ / 2] = parseInt(param1.substr(_loc3_,2),16);
            _loc3_ += 2;
         }
         return _loc2_;
      }
    static fromArray(param1, param2 = false) {
         var _loc3_ = "";
         var _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ += ("0" + param1[_loc4_].toString(16)).substr(-2,2);
            if(param2)
            {
               if(_loc4_ < param1.length - 1)
               {
                  _loc3_ += ":";
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
    static dump(param1) {
         var _loc5_ = 0;
         var _loc2_ = "";
         var _loc3_ = "";
         var _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(_loc4_ % 16 == 0)
            {
               _loc2_ += ("00000000" + _loc4_.toString(16)).substr(-8,8) + " ";
            }
            if(_loc4_ % 8 == 0)
            {
               _loc2_ += " ";
            }
            _loc5_ = $.int(param1[_loc4_]);
            _loc2_ += ("0" + _loc5_.toString(16)).substr(-2,2) + " ";
            _loc3_ += _loc5_ < 32 || _loc5_ > 126 ? "." : String.fromCharCode(_loc5_);
            if((_loc4_ + 1) % 16 == 0 || _loc4_ == param1.length - 1)
            {
               _loc2_ += " |" + _loc3_ + "|\n";
               _loc3_ = "";
            }
            _loc4_++;
         }
         return _loc2_;
      }
    static undump(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc2_ = new ($.C("flash.utils.ByteArray"))();
         var _loc3_ = param1.split(/(\n|\r)+/);
         while(_loc3_.length > 0 && _loc3_[0].length > 0)
         {
            _loc4_ = _loc3_.shift().substr(10).split("  |")[0].split(/\s+/);
            while(_loc4_.length > 0 && _loc4_[0].length > 0)
            {
               _loc2_.writeByte(parseInt(_loc4_.shift(),16));
            }
         }
         _loc2_.position = 0;
         return _loc2_;
      }
    static toString(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = __Hex.toArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
    static fromString(param1, param2 = false) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         _loc3_.writeUTFBytes(param1);
         return __Hex.fromArray(_loc3_,param2);
      }
  }
  $.meta(__Hex, "com.hurlant.util.Hex", []);
  return __Hex;
}
deps["com.hurlant.util.Hex"] = ["flash.utils.ByteArray"];

defs["com.hurlant.util.Memory"] = function define($) {
  const __Base = $.Object;
  class __Memory extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static gc() {
         try
         {
            new ($.C("flash.net.LocalConnection"))().connect("foo");
            new ($.C("flash.net.LocalConnection"))().connect("foo");
         }
         catch(e)
         {
         }
      }
    static get used() {
         return $.C("flash.system.System").totalMemory;
      }
    static set used(v) { super.used = v; }
  }
  $.meta(__Memory, "com.hurlant.util.Memory", []);
  return __Memory;
}
deps["com.hurlant.util.Memory"] = ["flash.net.LocalConnection", "flash.system.System"];

defs["loading.MaxLoading"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MaxLoading extends __Base {
    static $fields(self) {
    self.LABEL_CLEAR = 76;
    self.LABEL_OUT = 44;
    self._loadingMc = null;
    self._doctorFrame = null;
    self._noticeFrame = null;
    self._bgMovie = null;
    self._backShape = null;
    self._contentSp = null;
    self._loadingBg = null;
    self._stage = null;
    self._effectDoctor = null;
    self._effectDoctorTimeId = 0;
    self._effectNotice = null;
    self._effectNoticeTimeId = 0;
    self._currProgress = 0;
    self._preProgress = -1;
    self._count = 0;
    self._pro = 0;
    self._logoMove = null;
    }
    constructor() {
         super();
         this.init();
      }
    static get Instance() {
         if(__MaxLoading._instance == null)
         {
            __MaxLoading._instance = new (__MaxLoading)();
         }
         return __MaxLoading._instance;
      }
    init() {
         var _loc1_ = null;
         this._backShape = new ($.C("flash.display.Shape"))();
         this._contentSp = new ($.C("flash.display.Sprite"))();
         this._backShape.graphics.beginFill(0,1);
         this._backShape.graphics.drawRect(-200,-200,1900,1300);
         this._backShape.graphics.endFill();
         this.addChild(this._backShape);
         this.addChild(this._contentSp);
         if(!$.C("com.pickgliss.loader.ModuleLoader").hasDefinition("asset.loading.MainLoadingAsset"))
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("mainloading");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,8,$.bind(this, "__loadingCompleteHandler"));
         }
         else
         {
            this.createLoadingMc();
         }
      }
    __loadingCompleteHandler(param1, param2) {
         this.createLoadingMc();
         this.show(this._stage);
      }
    addBgToMc(param1) {
         var _loc2_ = null;
         if(this._loadingMc && param1)
         {
            if(param1.bg)
            {
               _loc2_ = $.as(param1.bg, $.C("flash.display.Bitmap"));
               if(_loc2_.width > 1000 || _loc2_.width < 900 || _loc2_.height > 600 || _loc2_.height < 500)
               {
                  _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(param1.url);
               }
               this._loadingMc.maxLoadingBg.addChild(_loc2_);
            }
            else
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(param1.url);
               this._loadingMc.maxLoadingBg.addChild(_loc2_);
            }
         }
      }
    createLoadingMc() {
         var _loc2_ = $.as($.C("com.pickgliss.loader.ModuleLoader").getDefinition("asset.loading.MainLoadingAsset"), "Class");
         this._loadingMc = $.as(new _loc2_(), $.C("flash.display.MovieClip"));
         this._loadingMc.loadPro.selectable = false;
         this._loadingMc.loadPro.mouseEnabled = false;
         this._loadingMc.loadPro.mouseWheelEnabled = false;
         this._loadingMc.childLoadPro.selectable = false;
         this._loadingMc.childLoadPro.mouseEnabled = false;
         this._loadingMc.childLoadPro.mouseWheelEnabled = false;
         this._loadingMc.doctor.addEventListener("click",$.bind(this, "__doctorHandler"));
         this._loadingMc.notice.addEventListener("click",$.bind(this, "__noticeHandler"));
         this._loadingMc.notice.visible = false;
         this.setProgress(1);
         this.setItemLoaderInfo(0,"");
         if(!__MaxLoading.showNetTips && this._loadingMc.netTips)
         {
            this._loadingMc.netTips.visible = false;
         }
         var _loc1_ = $.as($.C("com.pickgliss.loader.ModuleLoader").getDefinition("asset.loading.bgMovie"), "Class");
         this._bgMovie = new _loc1_();
         this._bgMovie.gotoAndPlay(1);
      }
    show(param1) {
         this._stage = param1;
         if(!$.C("com.pickgliss.loader.ModuleLoader").hasDefinition("asset.loading.MainLoadingAsset"))
         {
            return;
         }
         if(__MaxLoading.loadingSusliks)
         {
            this._stage.addEventListener("mouseDown",$.bind(this, "__mouseDown"));
            this._stage.addEventListener("mouseUp",$.bind(this, "__mouseUp"));
         }
         this._contentSp.addChild(this._loadingMc);
         this._contentSp.x = (this._stage.stageWidth - 1000) / 2;
         this._contentSp.y = (this._stage.stageHeight - 600) / 2;
         if(this._logoMove)
         {
            this._logoMove.x = this._contentSp.x + 418;
            this._logoMove.y = this._contentSp.y + 14;
         }
         this._bgMovie.x = this._loadingMc.loadPro.x - 215;
         this._bgMovie.y = this._loadingMc.loadPro.y - 378;
         this.addEventListener("enterFrame",$.bind(this, "__enterFrameHandler"));
         this._stage.addChild(this);
      }
    __noticeHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         this.__disposeDoctorHandler(null);
         if(this._noticeFrame)
         {
            this._noticeFrame.visible = true;
         }
         else if($.C("com.pickgliss.loader.ModuleLoader").hasDefinition("notice.NoticeStyle"))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition("notice.NoticeStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
            this._noticeFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("notice.NoticeFrame");
            this._noticeFrame["load"]();
            this._noticeFrame.addEventListener("dispose",$.bind(this, "__disposeNoticeHandler"));
            this._noticeFrame.addEventListener("min",$.bind(this, "__minNoticeHandler"));
            this.addChild(this._noticeFrame);
         }
         else
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("18.png");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,3,8,$.bind(this, "__noticeLoadCompleteHandler"));
         }
      }
    __noticeLoadCompleteHandler(param1, param2) {
         var _loc3_ = null;
         this.__disposeDoctorHandler(null);
         this.__disposeNoticeHandler(null);
         if($.C("com.pickgliss.loader.ModuleLoader").hasDefinition("notice.NoticeStyle"))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition("notice.NoticeStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
         }
         this._noticeFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("notice.NoticeFrame");
         this._noticeFrame["load"]();
         this._noticeFrame.addEventListener("dispose",$.bind(this, "__disposeNoticeHandler"));
         this._noticeFrame.addEventListener("min",$.bind(this, "__minNoticeHandler"));
         this.addChild(this._noticeFrame);
      }
    __doctorHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         this.__disposeNoticeHandler(null);
         if(this._doctorFrame)
         {
            this._doctorFrame.visible = true;
         }
         else if($.C("com.pickgliss.loader.ModuleLoader").hasDefinition("doctor.DoctorStyle"))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition("doctor.DoctorStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
            this._doctorFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.DoctorFrame");
            this._doctorFrame.addEventListener("dispose",$.bind(this, "__disposeDoctorHandler"));
            this._doctorFrame.addEventListener("min",$.bind(this, "__minDoctorHandler"));
            this.addChild(this._doctorFrame);
         }
         else
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getProjectSourcePath("18.png");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,3,8,$.bind(this, "__doctorLoadCompleteHandler"));
         }
      }
    __doctorLoadCompleteHandler(param1, param2) {
         var _loc3_ = null;
         this.__disposeNoticeHandler(null);
         if($.C("com.pickgliss.loader.ModuleLoader").hasDefinition("doctor.DoctorStyle"))
         {
            _loc3_ = $.C("com.pickgliss.loader.ModuleLoader").getDefinition("doctor.DoctorStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
         }
         this._doctorFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.DoctorFrame");
         this._doctorFrame.addEventListener("dispose",$.bind(this, "__disposeDoctorHandler"));
         this._doctorFrame.addEventListener("min",$.bind(this, "__minDoctorHandler"));
         this.addChild(this._doctorFrame);
      }
    __minDoctorHandler(param1) {
         this._doctorFrame.visible = false;
         this._effectDoctor = $.C("com.pickgliss.effect.EffectManager").Instance.creatEffect(3,this._loadingMc.doctor,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         this._effectDoctor.play();
         this._effectDoctorTimeId = $.C("flash.utils.setTimeout")($.bind(this, "stopDoctorEffect"),3000);
      }
    __minNoticeHandler(param1) {
         this._noticeFrame.visible = false;
         this._effectNotice = $.C("com.pickgliss.effect.EffectManager").Instance.creatEffect(3,this._loadingMc.notice,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         this._effectNotice.play();
         this._effectNoticeTimeId = $.C("flash.utils.setTimeout")($.bind(this, "stopNoticeEffect"),3000);
      }
    stopNoticeEffect() {
         $.C("flash.utils.clearTimeout")(this._effectNoticeTimeId);
         this._effectNoticeTimeId = 0;
         this._effectNotice.stop();
         this._effectNotice.dispose();
         this._effectNotice = null;
      }
    stopDoctorEffect() {
         $.C("flash.utils.clearTimeout")(this._effectDoctorTimeId);
         this._effectDoctorTimeId = 0;
         this._effectDoctor.stop();
         this._effectDoctor.dispose();
         this._effectDoctor = null;
      }
    __disposeNoticeHandler(param1) {
         if(this._noticeFrame)
         {
            this._noticeFrame.removeEventListener("min",$.bind(this, "__minNoticeHandler"));
            this._noticeFrame.removeEventListener("dispose",$.bind(this, "__disposeNoticeHandler"));
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._noticeFrame);
            this._noticeFrame = null;
         }
      }
    __disposeDoctorHandler(param1) {
         if(this._doctorFrame)
         {
            this._doctorFrame.removeEventListener("min",$.bind(this, "__minDoctorHandler"));
            this._doctorFrame.removeEventListener("dispose",$.bind(this, "__disposeDoctorHandler"));
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._doctorFrame);
            this._doctorFrame = null;
         }
      }
    __enterFrameHandler(param1) {
         this._contentSp.x = (this._stage.stageWidth - 1000) / 2;
         this._contentSp.y = (this._stage.stageHeight - 600) / 2;
         if(this._logoMove)
         {
            this._logoMove.x = this._contentSp.x + 418;
            this._logoMove.y = this._contentSp.y + 14;
         }
         this._bgMovie.x = this._loadingMc.loadPro.x - 215;
         this._bgMovie.y = this._loadingMc.loadPro.y - 378;
         if(this._doctorFrame)
         {
            this._doctorFrame.x = (this._stage.stageWidth - 546) / 2 + 20;
            this._doctorFrame.y = (this._stage.stageHeight - 410) / 2;
         }
         if(this._noticeFrame)
         {
            this._noticeFrame.x = (this._stage.stageWidth - 635) / 2 + 20;
            this._noticeFrame.y = (this._stage.stageHeight - 427) / 2;
         }
      }
    setProgress(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._loadingMc)
         {
            return;
         }
         this._pro = param1;
         this._loadingMc.progressBarMc.pro.gotoAndStop(this._pro);
         this._loadingMc.loadPro.text = "Progresso Total   " + this._pro + "%";
      }
    setItemLoaderInfo(param1, param2) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if(!this._loadingMc)
         {
            return;
         }
         var _loc3_ = param1 * 100;
         this._loadingMc.childProgressBarMc.pro.gotoAndStop(_loc3_);
         if(param2)
         {
            this._loadingMc.childLoadPro.text = param2 + "     Progresso" + _loc3_ + "%";
         }
         else
         {
            this._loadingMc.childLoadPro.text = "     Progresso" + _loc3_ + "%";
         }
      }
    hide() {
         this._currProgress = 1;
         this.removeEventListener("enterFrame",$.bind(this, "__enterFrameHandler"));
         this.hideSusliksl();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._backShape);
         this._backShape = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentSp);
         this._contentSp = null;
         if(this._loadingMc)
         {
            this._loadingMc.doctor.removeEventListener("click",$.bind(this, "__doctorHandler"));
            this._loadingMc.notice.removeEventListener("click",$.bind(this, "__noticeHandler"));
            this._loadingMc.stop();
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._loadingMc);
         this._loadingMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._logoMove);
         this._logoMove = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._bgMovie);
         this._bgMovie = null;
         if(this._doctorFrame)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._doctorFrame);
         }
         this._doctorFrame = null;
         this._stage = null;
         __MaxLoading._instance = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    hideSusliksl() {
         if(__MaxLoading.loadingSusliks)
         {
            this.resetCursor();
         }
         if(this._stage)
         {
            this._stage.removeEventListener("mouseDown",$.bind(this, "__mouseDown"));
         }
         if(this._stage)
         {
            this._stage.removeEventListener("mouseUp",$.bind(this, "__mouseUp"));
         }
      }
    initStick() {
         if($.C("com.pickgliss.ui.ComponentSetting").isZhanQu)
         {
            this._logoMove = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.loading.SlogoOld");
         }
         else if($.C("com.pickgliss.ui.ComponentSetting").is7road)
         {
            this._logoMove = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.loading.SlogoOld");
         }
         else
         {
            this._logoMove = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.loading.SlogoOld");
         }
      }
    frameUpdateView() {
      }
    growSusliks(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1)
         {
            param1.x = Math.random() * this._stage.stageWidth / 2 + this._stage.stageWidth / 4;
            param1.y = Math.random() * this._stage.stageHeight / 2 + this._stage.stageHeight / 4;
            this.addChild(param1);
            param1.gotoAndPlay(1);
         }
         $.C("flash.utils.clearTimeout")(param2);
      }
    __mouseDown(param1) {
      }
    __mouseUp(param1) {
      }
    resetCursor() {
      }
    showCursorByType() {
      }
    static set Instance(v) { super.Instance = v; }
  }
  $.meta(__MaxLoading, "loading.MaxLoading", []);
  $.statics(__MaxLoading, () => {
    __MaxLoading.loadingSusliks = false;
    __MaxLoading.showNetTips = false;
    __MaxLoading._instance = null;
  });
  return __MaxLoading;
}
deps["loading.MaxLoading"] = ["com.pickgliss.effect.EffectManager", "com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.ModuleLoader", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.MovieClip", "flash.display.Shape", "flash.display.Sprite", "flash.utils.clearTimeout", "flash.utils.setTimeout"];

defs["loading.MaxLoadingII"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MaxLoadingII extends __Base {
    static $fields(self) {
    self._loadingMc = null;
    self._container = null;
    self._currProgress = 0;
    self._preProgress = -1;
    self._count = 0;
    self._pro = 0;
    }
    constructor() {
         super();
         this.init();
      }
    static get Instance() {
         if(__MaxLoadingII._instance == null)
         {
            __MaxLoadingII._instance = new (__MaxLoadingII)();
         }
         return __MaxLoadingII._instance;
      }
    init() {
         var _loc1_ = null;
         if(!$.C("com.pickgliss.loader.ModuleLoader").hasDefinition("asset.loading.MainLoadingAssetII"))
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentSetting").getUISourcePath("mainloadingii");
            $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc1_,3,8,$.bind(this, "__loadingCompleteHandler"));
         }
         else
         {
            this.createLoadingMc();
         }
      }
    __loadingCompleteHandler(param1, param2) {
         this.createLoadingMc();
         this.show(this._container);
      }
    createLoadingMc() {
         var _loc1_ = $.as($.C("com.pickgliss.loader.ModuleLoader").getDefinition("asset.loading.MainLoadingAssetII"), "Class");
         this._loadingMc = $.as(new _loc1_(), $.C("flash.display.MovieClip"));
         this._loadingMc.loadPro.selectable = false;
         this._loadingMc.loadPro.mouseEnabled = false;
         this._loadingMc.loadPro.mouseWheelEnabled = false;
         this._loadingMc.childLoadPro.selectable = false;
         this._loadingMc.childLoadPro.mouseEnabled = false;
         this._loadingMc.childLoadPro.mouseWheelEnabled = false;
         try
         {
            this._loadingMc.notice.visible = false;
         }
         catch(e)
         {
         }
         this.setProgress(1);
         this.setItemLoaderInfo(0,"");
      }
    show(param1) {
         this._container = param1;
         if(!$.C("com.pickgliss.loader.ModuleLoader").hasDefinition("asset.loading.MainLoadingAssetII"))
         {
            return;
         }
         this._loadingMc.x = 200;
         this._loadingMc.y = 110;
         this._container.addChild(this._loadingMc);
      }
    setProgress(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._loadingMc)
         {
            return;
         }
         this._pro = param1;
         this._loadingMc.progressBarMc.pro.gotoAndStop(this._pro);
         this._loadingMc.loadPro.text = "Progresso Total   " + this._pro + "%";
      }
    setItemLoaderInfo(param1, param2) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if(!this._loadingMc)
         {
            return;
         }
         var _loc3_ = param1 * 100;
         this._loadingMc.childProgressBarMc.pro.gotoAndStop(_loc3_);
         if(param2)
         {
            this._loadingMc.childLoadPro.text = param2 + "     Progresso" + _loc3_ + "%";
         }
         else
         {
            this._loadingMc.childLoadPro.text = "     Progresso" + _loc3_ + "%";
         }
      }
    hide() {
         this._currProgress = 1;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._loadingMc);
         this._loadingMc = null;
         this._container = null;
         __MaxLoadingII._instance = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    static set Instance(v) { super.Instance = v; }
  }
  $.meta(__MaxLoadingII, "loading.MaxLoadingII", []);
  $.statics(__MaxLoadingII, () => {
    __MaxLoadingII._instance = null;
  });
  return __MaxLoadingII;
}
deps["loading.MaxLoadingII"] = ["com.pickgliss.loader.LoaderManagerII", "com.pickgliss.loader.ModuleLoader", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite"];

defs["loading.RegisterLoading"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RegisterLoading extends __Base {
    static $fields(self) {
    self._loadingMc = null;
    }
    constructor() {
         super();
         this.initView();
      }
    static get instance() {
         if(!__RegisterLoading._instance)
         {
            __RegisterLoading._instance = new (__RegisterLoading)();
         }
         return __RegisterLoading._instance;
      }
    initView() {
         if($.C("com.pickgliss.ui.ComponentSetting").isZhanQu)
         {
            this._loadingMc = new ($.C("asset.smallloading.RegisterLoadingMc2"))();
            this._loadingMc["bg1"].gotoAndStop(2);
            this._loadingMc["bg2"].gotoAndStop(2);
         }
         else if($.C("com.pickgliss.ui.ComponentSetting").is7road)
         {
            this._loadingMc = new ($.C("asset.smallloading.RegisterLoadingMc2"))();
            this._loadingMc["bg1"].gotoAndStop(1);
            this._loadingMc["bg2"].gotoAndStop(1);
         }
         else
         {
            this._loadingMc = new ($.C("asset.smallloading.RegisterLoadingMc"))();
            this._loadingMc["bg1"].gotoAndStop(1);
            this._loadingMc["bg2"].gotoAndStop(1);
         }
         this._loadingMc.mouseEnabled = false;
         this._loadingMc.mouseChildren = false;
         this.progress = 1;
         this.addChild(this._loadingMc);
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,0,true,true,2);
      }
    hide() {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set progress(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._loadingMc)
         {
            this._loadingMc.gotoAndStop(param1);
         }
      }
    exit(param1 = null) {
         this.dispose();
         if(param1 != null)
         {
            param1();
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._loadingMc);
         this._loadingMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         __RegisterLoading._instance = null;
      }
    static set instance(v) { super.instance = v; }
    get progress() { return super.progress; }
  }
  $.meta(__RegisterLoading, "loading.RegisterLoading", []);
  $.statics(__RegisterLoading, () => {
    __RegisterLoading._instance = null;
  });
  return __RegisterLoading;
}
deps["loading.RegisterLoading"] = ["asset.smallloading.RegisterLoadingMc", "asset.smallloading.RegisterLoadingMc2", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["loading.SmallLoading"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SmallLoading extends __Base {
    static $fields(self) {
    self.LOADING_MIX_X = 205;
    self.LOADING_MIX_Y = 105;
    self._loadingMc = null;
    self._logoMc = null;
    self._logoBgMc = null;
    self._isShowLogo = false;
    self._hasInit = false;
    self._progressTimeId = 0;
    self._logoTimeId = 0;
    }
    constructor() {
         super();
      }
    static get Instance() {
         if(__SmallLoading._instance == null)
         {
            __SmallLoading._instance = new (__SmallLoading)();
         }
         return __SmallLoading._instance;
      }
    init() {
         this._hasInit = true;
         this._loadingMc = new ($.C("asset.loading.SmallLoadingAsset"))();
         this._loadingMc.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._loadingMc.width) / 2 + 205;
         this._loadingMc.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._loadingMc.height) / 2 + 105;
         this._loadingMc["PercentageMc"]["txtPercent"].text = "1";
         if(this._isShowLogo)
         {
            this._logoBgMc = $.as(new ($.C("asset.loading.LogoBgAsset"))(), $.C("flash.display.MovieClip"));
            this._logoBgMc.mouseEnabled = this._logoBgMc.mouseChildren = false;
            this._logoBgMc.width = $.C("com.pickgliss.toplevel.StageReferance").stageWidth;
            this._logoBgMc.height = $.C("com.pickgliss.toplevel.StageReferance").stageHeight;
            this.addChild(this._logoBgMc);
            this._logoMc = $.as(new ($.C("asset.loading.LogoAsset"))(), $.C("flash.display.MovieClip"));
            this._logoMc.mouseEnabled = this._logoMc.mouseChildren = false;
            this._logoMc.x = $.C("com.pickgliss.toplevel.StageReferance").stageWidth * 0.5;
            this._logoMc.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight * 0.5;
            this.addChild(this._logoMc);
            this._logoMc.gotoAndPlay(1);
            this.showProressDealy = 7000;
         }
         else
         {
            this.addChild(this._loadingMc);
         }
      }
    set showProressDealy(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._loadingMc["PercentageMc"].visible = false;
         if(this._progressTimeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._progressTimeId);
         }
         this._progressTimeId = 0;
         if(param1 > 0)
         {
            this._progressTimeId = $.C("flash.utils.setInterval")($.bind(this, "showProgress"),param1);
         }
      }
    showProgress() {
         $.C("flash.utils.clearInterval")(this._progressTimeId);
         this._loadingMc["PercentageMc"].visible = true;
         if(this._isShowLogo)
         {
            this.addChild(this._loadingMc);
         }
      }
    __resizeHandler(param1) {
         if(this._loadingMc)
         {
            this._loadingMc.x = ($.C("com.pickgliss.toplevel.StageReferance").stageWidth - this._loadingMc.width) / 2 + 205;
            this._loadingMc.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - this._loadingMc.height) / 2 + 105;
         }
         if(this._isShowLogo && this._logoMc)
         {
            this._logoMc.x = $.C("com.pickgliss.toplevel.StageReferance").stageWidth * 0.5;
            this._logoMc.y = $.C("com.pickgliss.toplevel.StageReferance").stageHeight * 0.5;
         }
         if(this._isShowLogo && this._logoBgMc)
         {
            this._logoBgMc.width = $.C("com.pickgliss.toplevel.StageReferance").stageWidth;
            this._logoBgMc.height = $.C("com.pickgliss.toplevel.StageReferance").stageHeight;
         }
      }
    show(param1 = false) {
         this._isShowLogo = param1;
         this.addEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addChild(this);
      }
    __addToStageHandler(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         if(!this._hasInit)
         {
            this.init();
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
      }
    set progress(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._loadingMc)
         {
            return;
         }
         this._loadingMc["PercentageMc"]["txtPercent"].text = param1;
      }
    exit(param1, param2 = null) {
         if(this._isShowLogo && this._logoMc)
         {
            this.callOnPlayOver($.bind(this, "exitCall"),param1,param2);
         }
         else
         {
            this.exitCall(param1,param2);
         }
      }
    callOnPlayOver(param1, param2 = null, param3 = null) {
         if(!this._logoMc)
         {
            param1(param2,param3);
            return;
         }
         var _loc4_ = (this._logoMc.totalFrames - this._logoMc.currentFrame) / $.C("com.pickgliss.toplevel.StageReferance").stage.frameRate * 1000;
         $.C("flash.utils.clearInterval")(this._logoTimeId);
         this._logoTimeId = $.C("flash.utils.setInterval")(param1,_loc4_,param2,param3);
      }
    exitCall(param1 = null, param2 = null) {
         this.dispose();
         if(param1 != null)
         {
            param1(param2);
            param1 = null;
         }
      }
    dispose() {
         $.C("flash.utils.clearInterval")(this._progressTimeId);
         this._progressTimeId = 0;
         $.C("flash.utils.clearInterval")(this._logoTimeId);
         this._logoTimeId = 0;
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._logoMc);
         this._logoMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._logoBgMc);
         this._logoBgMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loadingMc);
         this._loadingMc = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._logoBgMc);
         this._logoBgMc = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    static set Instance(v) { super.Instance = v; }
    get showProressDealy() { return super.showProressDealy; }
    get progress() { return super.progress; }
  }
  $.meta(__SmallLoading, "loading.SmallLoading", []);
  $.statics(__SmallLoading, () => {
    __SmallLoading._instance = null;
  });
  return __SmallLoading;
}
deps["loading.SmallLoading"] = ["asset.loading.LogoAsset", "asset.loading.LogoBgAsset", "asset.loading.SmallLoadingAsset", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.utils.clearInterval", "flash.utils.setInterval"];

defs["newbie.NewbieSPHelper"] = function define($) {
  const __Base = $.Object;
  class __NewbieSPHelper extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static saveNoviceProcess(param1, param2, param3 = null) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         param1["noviceProcess"] = param2;
         var _loc6_ = new ($.C("flash.net.URLLoader"))();
         var _loc4_ = new ($.C("flash.net.URLRequest"))($.C("com.pickgliss.ui.ComponentSetting").REQUEST_PATH + "updateplayernovice");
         _loc4_.method = "POST";
         var _loc5_ = new ($.C("flash.net.URLVariables"))();
         _loc5_["op"] = 1;
         _loc5_["userid"] = param1["userId"];
         _loc5_["noviceprocess"] = param1["noviceProcess"];
         _loc5_["key"] = param1["key"];
         _loc5_["rnd"] = Math.random();
         _loc4_.data = _loc5_;
         if(param3 != null)
         {
            _loc6_.addEventListener("complete",param3);
         }
         _loc6_.load(_loc4_);
      }
  }
  $.meta(__NewbieSPHelper, "newbie.NewbieSPHelper", []);
  $.statics(__NewbieSPHelper, () => {
    __NewbieSPHelper.NEWBIE_NAMEEND = 10000;
    __NewbieSPHelper.NEWBIE_START_CAMPAIGN = 11000;
    __NewbieSPHelper.NEWBIE_GOTOCASTLE = 19000;
  });
  return __NewbieSPHelper;
}
deps["newbie.NewbieSPHelper"] = ["com.pickgliss.ui.ComponentSetting", "flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables"];

defs["queue.LoginQueue"] = function define($) {
  const __Base = $.Object;
  class __LoginQueue extends __Base {
    static $fields(self) {
    self.backCall = null;
    self.errorCall = null;
    self._url = null;
    self._variable = null;
    self._timeId = 0;
    }
    constructor(param1, param2) {
         super();
         this._url = param1;
         this._variable = param2;
      }
    load() {
         $.C("flash.utils.clearInterval")(this._timeId);
         this._timeId = 0;
         this._variable["rnd"] = Math.random();
         var _loc1_ = new ($.C("flash.net.URLRequest"))(this._url);
         _loc1_.method = "POST";
         _loc1_.data = this._variable;
         var _loc2_ = new ($.C("flash.net.URLLoader"))();
         _loc2_.addEventListener("complete",$.bind(this, "__onLoginComplete"));
         _loc2_.addEventListener("ioError",$.bind(this, "__onLoginQueueError"));
         _loc2_.load(_loc1_);
      }
    __onLoginComplete(param1) {
         var _loc2_ = null;
         var _loc6_ = 0;
         var _loc3_ = null;
         var _loc5_ = 0;
         var _loc7_ = 0;
         var _loc8_ = null;
         $.C("flash.utils.clearInterval")(this._timeId);
         this._timeId = 0;
         var _loc4_ = $.XML(param1.target.data);
         if(_loc4_["@message"])
         {
            _loc2_ = $.str( _loc4_["@message"]);
            if(_loc2_.indexOf("|") != -1)
            {
               _loc3_ = _loc2_.split("|");
               _loc6_ = $.int(_loc3_[0]);
               if(_loc6_ > 300)
               {
                  _loc6_ = 30000;
               }
               else if(_loc6_ > 200)
               {
                  _loc6_ = 20000;
               }
               else if(_loc6_ > 100)
               {
                  _loc6_ = 10000;
               }
               else
               {
                  _loc6_ = 5000;
               }
               if($.int(_loc3_[1]) == -2)
               {
                  _loc5_ = -2;
                  if(this.errorCall != null)
                  {
                     this.errorCall("您当前所处列队位置：" + _loc3_[0] + "\n预计等待时间：" + (String($.int(_loc5_ / 60) + 1)) + "分钟以内",1,_loc5_,$.int(_loc3_[0]),$.int(_loc3_[2]));
                  }
               }
               else
               {
                  _loc5_ = $.int(_loc3_[1]) / 1000;
                  if(this.errorCall != null)
                  {
                     this.errorCall("您当前所处列队位置：" + _loc3_[0] + "\n预计等待时间：" + (String($.int(_loc5_ / 60) + 1)) + "分钟以内",1,$.int(_loc5_ / 60) + 1,$.int(_loc3_[0]),$.int(_loc3_[2]));
                  }
               }
               this._timeId = $.C("flash.utils.setInterval")($.bind(this, "load"),_loc6_);
            }
            else
            {
               _loc7_ = $.int( $.int(_loc4_["@userId"]));
               _loc8_ = $.str( _loc4_["@value"]);
               if(_loc7_ != 0 && _loc8_ != "false")
               {
                  if(this.backCall != null)
                  {
                     this.backCall(_loc4_);
                  }
                  this.backCall = null;
                  param1.target.removeEventListener("complete",$.bind(this, "__onLoginComplete"));
                  param1.target.removeEventListener("ioError",$.bind(this, "__onLoginQueueError"));
                  this.errorCall = null;
               }
               else if(this.errorCall != null)
               {
                  this.errorCall(_loc4_["@message"],0);
               }
            }
         }
         else if(this.errorCall != null)
         {
            this.errorCall("error",0);
         }
         $.C("flash.system.System").disposeXML(_loc4_);
         _loc4_ = null;
      }
    __onLoginQueueError(param1) {
         throw new ($.C("flash.events.ErrorEvent"))("SELECTLIST_LOAD_ERROR",true,false,"Load selectList fail! please try again later!");
      }
  }
  $.meta(__LoginQueue, "queue.LoginQueue", []);
  return __LoginQueue;
}
deps["queue.LoginQueue"] = ["flash.events.ErrorEvent", "flash.net.URLLoader", "flash.net.URLRequest", "flash.system.System", "flash.utils.clearInterval", "flash.utils.setInterval"];

defs["queue.LoginQueueView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __LoginQueueView extends __Base {
    static $fields(self) {
    self._queueView = null;
    self._stage = null;
    self._numberAsset = null;
    self._copy = null;
    }
    constructor(param1) {
         super();
         this._stage = param1;
         this.init();
         this.addEvent();
      }
    init() {
         this._copy = new ($.C("utils.CopyBitmapDataUtils"))();
         this._numberAsset = new ($.C("asset.queue.QueueNumberAsset"))();
         this._queueView = new ($.C("asset.queue.QueueAsset"))();
         this.addChild(this._queueView);
         this._stage.addChild(this);
         this.__resizeHandler(null);
      }
    addEvent() {
         this._stage.addEventListener("resize",$.bind(this, "__resizeHandler"));
      }
    __resizeHandler(param1) {
         this._queueView.x = this._stage.stageWidth - this._queueView.width >> 1;
         this._queueView.y = this._stage.stageHeight - this._queueView.height >> 1;
      }
    update(param1, param2, param3) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         this._queueView.countTxt.text = "" + String(param3);
         if(param1 == -2)
         {
            this._queueView.timeTxt.text = "正在估算中";
         }
         else
         {
            this._queueView.timeTxt.text = "" + String(param1) + "  分钟";
         }
         this._copy.getNumberView(param2,this._queueView.numberPos,this._numberAsset,20,22,15,20);
      }
    dispose() {
         if(this._stage)
         {
            this._stage.removeEventListener("resize",$.bind(this, "__resizeHandler"));
         }
         this._stage = null;
         if(this._queueView)
         {
            this._queueView.stop();
            if(this._queueView.parent)
            {
               this._queueView.parent.removeChild(this._queueView);
            }
            this._queueView = null;
         }
         this._copy = null;
         if(this._numberAsset)
         {
            this._numberAsset.dispose();
         }
         this._numberAsset = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__LoginQueueView, "queue.LoginQueueView", []);
  return __LoginQueueView;
}
deps["queue.LoginQueueView"] = ["asset.queue.QueueAsset", "asset.queue.QueueNumberAsset", "flash.display.Sprite", "utils.CopyBitmapDataUtils"];

defs["register.HeadComp"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __HeadComp extends __Base {
    static $fields(self) {
    self._bg = null;
    self._selectedBg = null;
    self._lightBg = null;
    self._head = null;
    self._container = null;
    self._selected = false;
    self.headId = 0;
    self._clickRecall = null;
    }
    constructor(param1, param2) {
         $.pre(new.target, (__s) => {
         __s.headId = param1;
         __s._clickRecall = param2;
         });
         super();
         $.preFlush(this, new.target);
      }
    init() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.headBg" + this.headId);
         this._head = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.head" + this.headId);
         this._selectedBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.selectedBg" + this.headId);
         this._lightBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.lightBg" + this.headId);
         this._container = new ($.C("flash.display.Sprite"))();
         this.addChild(this._container);
         this.addChild(this._selectedBg);
         this._selectedBg.x = -15;
         this._selectedBg.y = -16;
         this.addChild(this._lightBg);
         this._lightBg.x = -145;
         this._lightBg.y = 120;
         this._container.addChild(this._bg);
         this._container.addChild(this._head);
         this._container.scaleX = 0.65;
         this._container.scaleY = 0.65;
         this._bg.smoothing = true;
         this._head.smoothing = true;
         this._selectedBg.visible = false;
         this._lightBg.visible = false;
         this.buttonMode = true;
         this.initEvent();
      }
    set selected(param1) {
         if(param1)
         {
            this._container.scaleX = this._container.scaleY = 1;
            this._container.x = -30;
            this._container.y = -45;
            this._selectedBg.visible = false;
            this._lightBg.visible = true;
            this.mouseEnabled = this.mouseChildren = false;
         }
         else
         {
            this._container.scaleX = this._container.scaleY = 0.65;
            this._container.x = 0;
            this._container.y = 0;
            this._lightBg.visible = false;
            this.mouseEnabled = this.mouseChildren = true;
         }
         this._selected = param1;
      }
    initEvent() {
         this.addEventListener("click",$.bind(this, "clickHandler"));
         this.addEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.addEventListener("mouseOut",$.bind(this, "__outHandler"));
      }
    removeEvent() {
         this.removeEventListener("click",$.bind(this, "clickHandler"));
         this.removeEventListener("mouseOver",$.bind(this, "__overHandler"));
         this.removeEventListener("mouseOut",$.bind(this, "__outHandler"));
      }
    __overHandler(param1) {
         if(this._selected)
         {
            this._selectedBg.visible = false;
         }
         else
         {
            this._selectedBg.visible = true;
         }
      }
    __outHandler(param1) {
         this._selectedBg.visible = false;
      }
    clickHandler(param1) {
         this._clickRecall.call(this,param1);
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._selectedBg);
         this._selectedBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lightBg);
         this._lightBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head);
         this._head = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._container);
         this._container = null;
         this._clickRecall = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get selected() { return super.selected; }
  }
  $.meta(__HeadComp, "register.HeadComp", []);
  return __HeadComp;
}
deps["register.HeadComp"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["register.MainFigureView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __MainFigureView extends __Base {
    static $fields(self) {
    self._viewRect = new ($.C("flash.geom.Rectangle"))(0,0,1400,800);
    self.MAX_LENGTH = 12;
    self.MIN_LENGTH = 4;
    self._back = null;
    self._showNetTips01 = null;
    self._showNetTips02 = null;
    self._bg = null;
    self._confirmBtn = null;
    self._containerHead = null;
    self._head1 = null;
    self._head2 = null;
    self._head3 = null;
    self._head4 = null;
    self._head5 = null;
    self._head6 = null;
    self._tipsBg = null;
    self._tipsContentTxt = null;
    self._shaiziBtn = null;
    self._renameTxt = null;
    self._describtTxt = null;
    self._figureNameBg = null;
    self._currentSelectRole = null;
    self._preSelectRole = null;
    self._userInfo = null;
    self._renameCallBack = null;
    self._nickName = "";
    self._txtChange = "";
    self._titlePos1 = 0;
    self._titlePos2 = 0;
    self._titlePos3 = 0;
    }
    constructor(param1, param2) {
         super();
         this._userInfo = param1;
         this._renameCallBack = param2;
         this.initView();
         this.addEvent();
      }
    get viewRectangle() {
         return this._viewRect;
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.Back");
         this._showNetTips01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.Back01");
         this._showNetTips02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainloadingii.register.Back02");
         this._bg = $.as($.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.mainloadingii.register.MainFigureBg"), $.C("flash.display.MovieClip"));
         this._confirmBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ConfirmBtn");
         this._head1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp1",[2,$.bind(this, "__roleClickHandler")]);
         this._head2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp2",[1,$.bind(this, "__roleClickHandler")]);
         this._head3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp3",[4,$.bind(this, "__roleClickHandler")]);
         this._head4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp4",[3,$.bind(this, "__roleClickHandler")]);
         this._head5 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp5",[6,$.bind(this, "__roleClickHandler")]);
         this._head6 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp6",[5,$.bind(this, "__roleClickHandler")]);
         this._tipsBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.commonTipBg");
         this._tipsContentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.commonTipText");
         this._shaiziBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ShaiziBtn");
         this._renameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ReNameTxt");
         this._describtTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mainloadingii.register.ChooseView.DescribeTxt");
         this._figureNameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.mainloadingii.register.figureNameBg");
         this._containerHead = new ($.C("flash.display.Sprite"))();
         this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         this._describtTxt.setFrame(2);
         this._containerHead.x = 50;
         this._containerHead.addChild(this._head1);
         this._containerHead.addChild(this._head2);
         this._containerHead.addChild(this._head3);
         this._containerHead.addChild(this._head4);
         this._containerHead.addChild(this._head5);
         this._containerHead.addChild(this._head6);
         this.addChild(this._back);
         this.addChild(this._bg);
         this.addChild(this._containerHead);
         this.addChild(this._confirmBtn);
         this.addChild(this._tipsContentTxt);
         this.addChild(this._shaiziBtn);
         this.addChild(this._figureNameBg);
         this.addChild(this._renameTxt);
         this.addChild(this._describtTxt);
         this._showNetTips01.visible = this._showNetTips02.visible = $.C("loading.MaxLoading").showNetTips;
         this._showNetTips01.x = this._back.x + (this._back.width - this._showNetTips01.width) * 0.5;
         this._showNetTips01.y = this._back.y + 30;
         this._showNetTips02.x = this._back.x + (this._back.width - this._showNetTips02.width) * 0.5;
         this._showNetTips02.y = this._back.y + this._back.height - this._showNetTips02.height - 30;
         this._titlePos1 = this._bg.title1.y;
         this._titlePos2 = this._bg.title3.y;
         this._titlePos3 = this._bg.title5.y;
         var _loc1_ = $.int(Math.random() * 6) + 1;
         this._preSelectRole = this["_head" + _loc1_];
         this._preSelectRole.dispatchEvent(new ($.C("flash.events.MouseEvent"))("click"));
         this._shaiziBtn.visible = false;
         this._renameTxt.text = $.C("manager.NamesLibManager").newName(this.getSex());
         if(this._renameTxt.text != "")
         {
            this._shaiziBtn.visible = true;
         }
      }
    uninitView() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._showNetTips01);
         this._showNetTips01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._showNetTips02);
         this._showNetTips02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._bg);
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._confirmBtn);
         this._confirmBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._containerHead);
         this._containerHead = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head1);
         this._head1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head2);
         this._head2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head3);
         this._head3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head4);
         this._head4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head5);
         this._head5 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head6);
         this._head6 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipsBg);
         this._tipsBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipsContentTxt);
         this._tipsContentTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._shaiziBtn);
         this._shaiziBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._renameTxt);
         this._renameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describtTxt);
         this._describtTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._figureNameBg);
         this._figureNameBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentSelectRole);
         this._currentSelectRole = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preSelectRole);
         this._preSelectRole = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._currentSelectRole = null;
         this._preSelectRole = null;
         this._userInfo = null;
         this._renameCallBack = null;
      }
    addEvent() {
         this._confirmBtn.addEventListener("click",$.bind(this, "__confirmBtnClickHandler"));
         this._shaiziBtn.addEventListener("click",$.bind(this, "__shaiziBtnClickHandler"));
         this._renameTxt.addEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         this._renameTxt.addEventListener("change",$.bind(this, "__onTxtChange"));
      }
    removeEvent() {
         if(this._confirmBtn)
         {
            this._confirmBtn.removeEventListener("click",$.bind(this, "__confirmBtnClickHandler"));
         }
         if(this._shaiziBtn)
         {
            this._shaiziBtn.removeEventListener("click",$.bind(this, "__shaiziBtnClickHandler"));
         }
         if(this._renameTxt)
         {
            this._renameTxt.removeEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         }
         if(this._renameTxt)
         {
            this._renameTxt.removeEventListener("change",$.bind(this, "__onTxtChange"));
         }
      }
    __shaiziBtnClickHandler(param1) {
         this._renameTxt.text = $.C("manager.NamesLibManager").newName(this.getSex());
      }
    __confirmBtnClickHandler(param1) {
         this.loadRegister();
      }
    __keyDownHandler(param1) {
         switch($.int(param1.keyCode) - 13)
         {
            case 0:
               this.__confirmBtnClickHandler(null);
         }
         param1.stopPropagation();
      }
    __onTxtChange(param1) {
         this._describtTxt.setFrame(2);
         this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         if(this.checkStringLength(this._renameTxt.text) > 12)
         {
            this._renameTxt.text = this._txtChange;
         }
         this._txtChange = this._renameTxt.text;
      }
    checkStringLength(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc2_ = new ($.C("flash.utils.ByteArray"))();
         _loc2_.writeMultiByte(param1,"");
         return _loc2_.length;
      }
    __roleClickHandler(param1) {
         if(this._currentSelectRole == param1.currentTarget)
         {
            return;
         }
         this._preSelectRole.selected = false;
         this._currentSelectRole = $.as(param1.currentTarget, $.C("register.HeadComp"));
         this._currentSelectRole.selected = true;
         this._preSelectRole = this._currentSelectRole;
         this._containerHead.addChildAt(this._currentSelectRole,this._containerHead.numChildren - 1);
         this.setBody(this._currentSelectRole.headId);
      }
    setBody(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = "asset.mainloadingii.register.RoleIcon_" + param1;
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc2_);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._bg.bodyContainer);
         this._bg.bodyContainer.addChild(_loc3_);
         this.reviseTitlePos(param1);
      }
    reviseTitlePos(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.title1.y = this._titlePos1;
         this._bg.title3.y = this._titlePos2;
         this._bg.title5.y = this._titlePos3;
         switch(param1 - 1)
         {
            case 0:
            case 1:
               this._bg.title1.y = this._titlePos1 - 40;
               break;
            case 2:
            case 3:
               this._bg.title3.y = this._titlePos2 - 40;
               break;
            case 4:
            case 5:
               this._bg.title5.y = this._titlePos3 - 40;
         }
      }
    getSex() {
         return this._currentSelectRole.headId % 2;
      }
    getIcon() {
         switch(this._currentSelectRole.headId - 1)
         {
            case 0:
            case 2:
               return this._currentSelectRole.headId;
            case 1:
               return 4;
            case 3:
               return 6;
            case 4:
               return 2;
            case 5:
               return 5;
            default:
               return 0;
         }
      }
    loadRegister() {
         this._nickName = this._renameTxt.text;
         this._nickName = this._nickName.replace("\r","");
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         _loc3_.writeMultiByte(this._nickName,"");
         var _loc4_ = $.int(_loc3_.length);
         if(this._nickName == "")
         {
            this._describtTxt.setFrame(1);
            this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt02");
            return;
         }
         if(_loc4_ < 4)
         {
            this._describtTxt.setFrame(1);
            this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt03");
            return;
         }
         if(_loc4_ > 12)
         {
            this._describtTxt.setFrame(1);
            this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt04");
            return;
         }
         if($.C("manager.FilterWordManager").containUnableChar(this._nickName) || $.C("manager.FilterWordManager").filterWrod(this._nickName) != this._nickName)
         {
            this._describtTxt.setFrame(1);
            this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.node.AddUserNameFrame.describt05");
            return;
         }
         this._confirmBtn.enable = false;
         var _loc1_ = new ($.C("flash.net.URLVariables"))();
         _loc1_["client"] = $.C("manager.DesktopManager").Instance.isDesktop;
         _loc1_["userid"] = this._userInfo.userId;
         _loc1_["nickname"] = this._nickName;
         _loc1_["jumpnovice"] = 0;
         _loc1_["camp"] = 1;
         _loc1_["sex"] = this.getSex();
         _loc1_["icon"] = this.getIcon();
         _loc1_["username"] = this._userInfo.user;
         _loc1_["site"] = this._userInfo.site;
         _loc1_["key"] = this._userInfo.key;
         _loc1_["ran"] = Math.random();
         var _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").REQUEST_PATH + "visualizeregister";
         $.C("com.pickgliss.loader.LoaderManagerII").instance.load(_loc2_,7,0,$.bind(this, "__onRegisterCompleteHandler"),null,$.bind(this, "__onRegisterErrorHandler"),null,_loc1_);
      }
    __onRegisterCompleteHandler(param1, param2) {
         var _loc3_ = null;
         var _loc9_ = 0;
         var _loc11_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc8_ = null;
         var _loc7_ = $.XML(param2);
         var _loc6_ = $.str( _loc7_["@value"]);
         var _loc10_ = $.int( $.int(_loc7_["@type"]));
         if(_loc6_ == "true" && (_loc10_ == 0 || _loc10_ == 3))
         {
            this._confirmBtn.enable = false;
            this.mouseEnabled = this.mouseChildren = false;
            $.C("manager.ExternalInterfaceManager").instance.setFirstLeave(this._userInfo.site,this._userInfo.user);
            _loc3_ = this._userInfo.site.split("_");
            if(_loc3_[0] == "duowan")
            {
               try
               {
                  _loc9_ = $.int(_loc3_[1]);
                  _loc11_ = "http://assist" + _loc9_ + ".shenqu.game.yy.com/";
                  _loc5_ = new ($.C("flash.net.URLVariables"))();
                  _loc5_["username"] = this._userInfo.user;
                  _loc5_["site"] = this._userInfo.site;
                  _loc5_["type"] = 4;
                  _loc5_["rnd"] = Math.random();
                  _loc4_ = new ($.C("flash.net.URLRequest"))(_loc11_ + "playerNotify");
                  _loc4_.data = _loc5_;
                  _loc8_ = new ($.C("flash.net.URLLoader"))();
                  _loc8_.load(_loc4_);
               }
               catch(e)
               {
               }
            }
            $.C("newbie.NewbieSPHelper").saveNoviceProcess(this._userInfo,10000,$.bind(this, "onNoviceProcessSaveComplete"));
         }
         else
         {
            if(this._confirmBtn)
            {
               this._confirmBtn.enable = true;
            }
            if(this._describtTxt)
            {
               this._describtTxt.setFrame(1);
               this._describtTxt.text = _loc7_["@message"];
            }
         }
      }
    __onRegisterErrorHandler(param1, param2) {
         this._confirmBtn.enable = true;
         this._describtTxt.setFrame(1);
         this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("noviceII.view.AddUserNameFrame.checkNickErrorEvent2");
      }
    onNoviceProcessSaveComplete(param1) {
         var _loc2_ = param1 ? $.as(param1.target, $.C("flash.net.URLLoader")) : null;
         if(_loc2_)
         {
            _loc2_.removeEventListener("complete",$.bind(this, "onNoviceProcessSaveComplete"));
         }
         this._confirmBtn.visible = false;
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
         if(this._renameCallBack != null)
         {
            this._renameCallBack();
         }
      }
    dispose() {
         this.removeEvent();
         this.uninitView();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__MainFigureView, "register.MainFigureView", ["IManualSize"]);
  return __MainFigureView;
}
deps["register.MainFigureView"] = ["com.pickgliss.loader.LoaderManagerII", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.utils.ObjectUtils", "flash.display.MovieClip", "flash.display.Sprite", "flash.events.MouseEvent", "flash.geom.Rectangle", "flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables", "flash.utils.ByteArray", "loading.MaxLoading", "manager.DesktopManager", "manager.ExternalInterfaceManager", "manager.FilterWordManager", "manager.LanguageMgr", "manager.NamesLibManager", "newbie.NewbieSPHelper", "register.HeadComp"];

defs["smallloading_fla.Timeline_11"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __Timeline_11 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.addFrameScript(0,$.bind(this, "frame1"),1,$.bind(this, "frame2"));
      }
    frame1() {
         this.stop();
      }
    frame2() {
         this.stop();
      }
  }
  $.meta(__Timeline_11, "smallloading_fla.Timeline_11", []);
  return __Timeline_11;
}
deps["smallloading_fla.Timeline_11"] = ["flash.display.MovieClip"];

defs["smallloading_fla.Timeline_2"] = function define($) {
  const __Base = $.C("flash.display.MovieClip");
  class __Timeline_2 extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this.addFrameScript(0,$.bind(this, "frame1"),1,$.bind(this, "frame2"));
      }
    frame1() {
         this.stop();
      }
    frame2() {
         this.stop();
      }
  }
  $.meta(__Timeline_2, "smallloading_fla.Timeline_2", []);
  return __Timeline_2;
}
deps["smallloading_fla.Timeline_2"] = ["flash.display.MovieClip"];

defs["utils.CopyBitmapDataUtils"] = function define($) {
  const __Base = $.Object;
  class __CopyBitmapDataUtils extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    getNumberView(param1, param2, param3, param4 = 30, param5 = 36, param6 = 25, param7 = 30, param8 = "0123456789.", param9 = 2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param4 !== "number") param4 = Number(param4);
         if (typeof param5 !== "number") param5 = Number(param5);
         if (typeof param6 !== "number" || (param6 | 0) !== param6) param6 = $.int(param6);
         if (typeof param7 !== "number" || (param7 | 0) !== param7) param7 = $.int(param7);
         if (param8 != null && typeof param8 !== "string") param8 = String(param8);
         if (typeof param9 !== "number" || (param9 | 0) !== param9) param9 = $.int(param9);
         var _loc11_ = 0;
         var _loc15_ = null;
         var _loc12_ = 0;
         var _loc13_ = null;
         this.removeTimeView(param2);
         var _loc14_ = param1 + "";
         if(param9 == 2)
         {
            _loc14_ = param1 < 10 ? "0" + param1 : "" + param1;
         }
         var _loc10_ = new ($.C("flash.display.Sprite"))();
         _loc11_ = 0;
         while(_loc11_ < _loc14_.length)
         {
            _loc15_ = _loc14_.substr(_loc11_,1);
            _loc12_ = param8.indexOf(_loc15_);
            _loc13_ = this.getBit(param3,param4,param5,_loc12_ * param7,0);
            _loc13_.x = _loc11_ * param6;
            _loc10_.addChild(_loc13_);
            _loc11_++;
         }
         param2.addChild(_loc10_);
         if(param1 < 0)
         {
            this.removeTimeView(param2);
         }
      }
    removeTimeView(param1) {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
    getBit(param1, param2, param3, param4, param5) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if (typeof param5 !== "number" || (param5 | 0) !== param5) param5 = $.int(param5);
         var _loc8_ = new ($.C("flash.display.Bitmap"))(new ($.C("flash.display.BitmapData"))(param2,param3,true,0));
         var _loc6_ = new ($.C("flash.geom.Rectangle"))(param4,param5,param2,param3);
         var _loc7_ = new ($.C("flash.geom.Point"))(0,0);
         _loc8_.bitmapData.copyPixels(param1,_loc6_,_loc7_,null,null,true);
         return _loc8_;
      }
  }
  $.meta(__CopyBitmapDataUtils, "utils.CopyBitmapDataUtils", []);
  return __CopyBitmapDataUtils;
}
deps["utils.CopyBitmapDataUtils"] = ["flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Sprite", "flash.geom.Point", "flash.geom.Rectangle"];

defs["utils.CrytoUtils"] = function define($) {
  const __Base = $.Object;
  class __CrytoUtils extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    static rsaEncry(param1, param2, param3) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         return __CrytoUtils.rsaEncry2($.C("com.hurlant.util.Base64").decodeToByteArray(param1),$.C("com.hurlant.util.Base64").decodeToByteArray(param2),param3);
      }
    static rsaEncry2(param1, param2, param3) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         var _loc6_ = new ($.C("com.hurlant.math.BigInteger"))(param1);
         var _loc5_ = new ($.C("com.hurlant.math.BigInteger"))(param2);
         var _loc4_ = new ($.C("com.hurlant.crypto.rsa.RSAKey"))(_loc6_,_loc5_.intValue());
         return __CrytoUtils.rsaEncry3(_loc4_,param3);
      }
    static generateRsaKey(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         return __CrytoUtils.generateRsaKey2($.C("com.hurlant.util.Base64").decodeToByteArray(param1),$.C("com.hurlant.util.Base64").decodeToByteArray(param2));
      }
    static generateRsaKey2(param1, param2) {
         var _loc4_ = new ($.C("com.hurlant.math.BigInteger"))(param1);
         var _loc3_ = new ($.C("com.hurlant.math.BigInteger"))(param2);
         return new ($.C("com.hurlant.crypto.rsa.RSAKey"))(_loc4_,_loc3_.intValue());
      }
    static rsaEncry3(param1, param2) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         _loc3_.writeUTF(param2);
         var _loc4_ = new ($.C("flash.utils.ByteArray"))();
         param1.encrypt(_loc3_,_loc4_,_loc3_.length);
         return $.C("com.hurlant.util.Base64").encodeByteArray(_loc4_);
      }
    static rsaEncry4(param1, param2) {
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         param1.encrypt(param2,_loc3_,param2.length);
         return $.C("com.hurlant.util.Base64").encodeByteArray(_loc3_);
      }
    static rsaEncry5(param1, param2) {
         var _loc3_ = new ($.C("flash.utils.ByteArray"))();
         param1.encrypt(param2,_loc3_,param2.length);
         return _loc3_;
      }
  }
  $.meta(__CrytoUtils, "utils.CrytoUtils", []);
  return __CrytoUtils;
}
deps["utils.CrytoUtils"] = ["com.hurlant.crypto.rsa.RSAKey", "com.hurlant.math.BigInteger", "com.hurlant.util.Base64", "flash.utils.ByteArray"];
