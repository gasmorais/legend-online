// @ts-nocheck
export const defs = {};
export const deps = {};
defs["doctor.DoctorFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __DoctorFrame extends __Base {
    static $fields(self) {
    self._minBtn = null;
    self._back1 = null;
    self._back2 = null;
    self._startDocBtn = null;
    self._copyBtn = null;
    self._decTxt = null;
    self._vbox = null;
    self._scrollPanel = null;
    self._itemList = null;
    self._copyText = null;
    self._resuleTxt = "";
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Back1");
         this._back2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Back2");
         this._startDocBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.StartBtn");
         this._copyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.CopyBtn");
         this._decTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Describetxt");
         this._vbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Vbox");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.ScrollPanel");
         this._minBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.MinBtn");
         this.addToContent(this._back1);
         this.addToContent(this._back2);
         this.addToContent(this._startDocBtn);
         this.addToContent(this._copyBtn);
         this.addToContent(this._decTxt);
         this.addToContent(this._scrollPanel);
         this.addToContent(this._minBtn);
         this._scrollPanel.setView(this._vbox);
         this._scrollPanel.vUnitIncrement = 58;
         this._copyText = new ($.C("flash.text.TextField"))();
         this._copyText.multiline = true;
         this._decTxt.htmlText = "<font color=\'#36ff00\'>Clique em </font><font color=\'#ffcd63\'>Iniciar Diagnóstico</font><font color=\'#36ff00\'> para iniciar diagnóstico de carregamento.</font>";
         this._startDocBtn.enable = false;
         this._copyBtn.visible = false;
         this.titleText = "Diagnóstico do Legend Online";
      }
    initEvent() {
         this._minBtn.addEventListener("click",$.bind(this, "__minHandler"));
         this._startDocBtn.addEventListener("click",$.bind(this, "__clickHandler"));
         this._copyBtn.addEventListener("click",$.bind(this, "__clickHandler"));
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this.addEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
      }
    removeEvent() {
         this._minBtn.removeEventListener("click",$.bind(this, "__minHandler"));
         this._startDocBtn.removeEventListener("click",$.bind(this, "__clickHandler"));
         this._copyBtn.removeEventListener("click",$.bind(this, "__clickHandler"));
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
      }
    __minHandler(param1) {
         this.dispatchEvent(new ($.C("flash.events.Event"))("min",false,false));
      }
    __addToStageHandler(param1) {
         this.removeEventListener("addedToStage",$.bind(this, "__addToStageHandler"));
         $.C("flash.system.Security").loadPolicyFile($.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + "crossdomain.xml");
         this.getSystemType();
         this.getBrowerType();
         this.tryCrossDomain();
         this.refreshLoaderList();
      }
    __clickHandler(param1) {
         if(param1.currentTarget == this._startDocBtn)
         {
            this._startDocBtn.visible = false;
            this._copyBtn.enable = false;
            this._copyBtn.visible = true;
            this.startCheck();
         }
         else
         {
            this.copyResule();
         }
      }
    __frameResponseHandler(param1) {
         switch(param1.responseCode)
         {
            case 0:
               this.dispose();
               break;
            case 1:
               this.dispose();
         }
      }
    startCheck() {
         this.loadNext();
      }
    getSystemType() {
         var _loc2_ = $.C("flash.system.Capabilities").os;
         var _loc1_ = $.C("flash.system.Capabilities").version;
         var _loc3_ = $.C("flash.system.Capabilities").playerType;
         this._resuleTxt += "Sistema: " + _loc2_ + ".<br>Versão do FlashPlayer:  " + _loc1_ + ".<br>Tipo do FlashPlayer: " + _loc3_ + ".<br>";
      }
    getBrowerType() {
         var _loc1_ = null;
         try
         {
            _loc1_ = $.C("manager.ExternalInterfaceManager").instance.getBrowerType();
            if(_loc1_)
            {
               this._resuleTxt += "Informações do Navegador: " + _loc1_ + ".<br>";
            }
            else
            {
               this._resuleTxt += "Informações do Navegador: Outros.<br>";
            }
         }
         catch(e)
         {
         }
      }
    tryCrossDomain() {
         var _loc1_ = new ($.C("flash.net.URLLoader"))();
         _loc1_.addEventListener("ioError",$.bind(this, "connectCrossDomainIOError"));
         _loc1_.addEventListener("init",$.bind(this, "connectCrossDomainProgress"));
         _loc1_.addEventListener("securityError",$.bind(this, "connectCrossDomainSecurityError"));
         _loc1_.load(new ($.C("flash.net.URLRequest"))($.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + "crossdomain.xml"));
      }
    connectCrossDomainIOError(param1) {
         this._resuleTxt += "Lendo " + $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + "crossdomain.xml erro IO;<br>";
      }
    connectCrossDomainProgress(param1) {
         this._resuleTxt += "Lendo " + $.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH + "Sucedido.<br>";
      }
    connectCrossDomainSecurityError(param1) {
         this._resuleTxt += "Lendo erro de sandbox crossdomain.xml.<br>";
         this._decTxt.htmlText = "<font color=\'#FF0000\'>Lendo erro sandbox crossdomain.xml</font>";
      }
    refreshLoaderList() {
         var _loc2_ = null;
         var _loc1_ = null;
         var _loc4_ = 1;
         this._itemList = [];
         for(var _loc3_ in $.C("com.pickgliss.ui.ComponentSetting").checkMD5)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getMD5FileNameByFilePath(_loc3_);
            _loc1_ = new ($.C("doctor.view.LoaderInfoItem"))(_loc4_ + " . " + _loc2_,_loc3_);
            this._vbox.addChild(_loc1_);
            this._itemList.push(_loc1_);
            _loc4_++;
         }
         this._scrollPanel.invalidateViewport();
         this._startDocBtn.enable = true;
      }
    loadNext() {
         var _loc1_ = null;
         if(this._itemList.length > 0)
         {
            _loc1_ = this._itemList.shift();
            _loc1_.start($.bind(this, "checkComplete"));
            if(_loc1_.y > _loc1_.viewRectangle.height * 10)
            {
               this._scrollPanel.vScrollbar.scrollValue = _loc1_.y - _loc1_.viewRectangle.height * 9;
            }
         }
         else
         {
            this._copyBtn.enable = true;
            this._decTxt.y -= 5;
            this._decTxt.htmlText = "Verificação dos documentos concluída, caso tenha aviso de erro, copie, salve e envie ao nosso SAC. <br>Caso verificação seja concluída, limpe cache do navegador e entre no jogo novamente.";
         }
      }
    checkComplete(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._resuleTxt += "Arquivo" + param1 + ".<br>";
         this.loadNext();
      }
    copyResule() {
         this._copyText.htmlText = this._resuleTxt;
         $.C("flash.system.System").setClipboard(this._copyText.text);
         this._decTxt.text = "Copiado com sucesso";
      }
    dispose() {
         if(this.isDie)
         {
            return;
         }
         this.removeEvent();
         for (var _loc1_ of $.values(this._itemList))
         {
            _loc1_.stop();
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back1);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back2);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startDocBtn);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._decTxt);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._copyBtn);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._copyText);
         this._back1 = null;
         this._back2 = null;
         this._startDocBtn = null;
         this._copyBtn = null;
         this._decTxt = null;
         this._itemList = null;
         this._copyText = null;
         this._resuleTxt = null;
         super.dispose();
      }
  }
  $.meta(__DoctorFrame, "doctor.DoctorFrame", []);
  return __DoctorFrame;
}
deps["doctor.DoctorFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "doctor.view.LoaderInfoItem", "flash.events.Event", "flash.net.URLLoader", "flash.net.URLRequest", "flash.system.Capabilities", "flash.system.Security", "flash.system.System", "flash.text.TextField", "manager.ExternalInterfaceManager"];

defs["doctor.DoctorStyle"] = function define($) {
  const __Base = $.Object;
  class __DoctorStyle extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         var _loc1_ = $.XML("<xml name=\"doctorstyle\">\n\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"doctor.FrameTitleText_t\" args=\"Arial,15,0xFFDD83,true\" letterSpacing=\"0\"/>\n\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"doctor.Describetxt_t\" args=\"Arial,12,0xffffff,\" letterSpacing=\"0\"/>\n\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"doctor.LoaderItemResule_t\" args=\"Arial,12,0xffffff,,,,,,left\" letterSpacing=\"0\"/>\n\t\t\t\n\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"doctor.FrameTitile_g\" args=\"0x000000,1,5,5,5\" />\n\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"doctor.DefaultFilter\" args=\"1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0\" />\n\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"doctor.LightFilter\" args=\"1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0\"/>\n\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"doctor.GrayFilter\" args=\"0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0\"/>\n\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"doctor.normal_f\" args=\"0x000000,1,5,5,3\" />\t\t\n\t\t\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.FrameTitleText\" \n\t\t\t\t\ttextFormatStyle=\"doctor.FrameTitleText_t\" filterString=\"doctor.FrameTitile_g\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"doctor.CloseBtn\" \n\t\t\t\t\tbackStyle=\"asset.core.closeBtn_style01\" filterString=\"doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter\"\n\t\t\t\t\tdisplacement='false' isFollowMouse = \"false\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.Scale9CornerImage\" stylename=\"doctor.FrameBackgoundBase1\" \n\t\t\t\t\tresourceLink=\"asset.core.framestyle03_scale9bg1,asset.core.framestyle03_scale9bg2,asset.core.framestyle03_scale9bg3,asset.core.framestyle03_scale9bg4,asset.core.framestyle03_scale9bg5,asset.core.framestyle03_scale9bg6,asset.core.framestyle03_scale9bg7,asset.core.framestyle03_scale9bg8,asset.core.framestyle03_scale9bg9\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.Image\" stylename=\"doctor.FrameTitleImage1\" \n\t\t\t\t\tresourceLink=\"asset.core.frameTitleImage2\"\n\t\t\t\t\twidth=\"229\" height=\"17\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.MutipleImage\" stylename=\"doctor.FrameBg1\"\n\t\t\t\t\tresourceLink=\"doctor.FrameBackgoundBase1,doctor.FrameTitleImage1\" imageRectString=\"-18|-15|0|23|0,232|17|-4|0|9\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"doctor.DoctorFrame\" stylename=\"doctor.DoctorFrame\"\n\t\t\t\t\tclosestyle=\"doctor.CloseBtn\" titleStyle=\"doctor.FrameTitleText\" backStyle=\"doctor.FrameBg1\" \n\t\t\t\t\tcloseInnerRectString=\"29,-31,-13,29,14\" \n\t\t\t\t\tmoveInnerRectString=\"0,80,0,25,1\" titleOuterRectPosString=\"0,-5,1\"\n\t\t\t\t\tmoveEnable=\"false\" enterEnable=\"true\" escEnable=\"true\"\n\t\t\t\t\tcontainerX=\"-6\" containerY=\"8\"\n\t\t\t\t\twidth=\"513\" height=\"392\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"doctor.MinBtn\" \n\t\t\t\t\tbackStyle=\"asset.loading.DoctorMinBtn\"  displacement=\"false\"\n\t\t\t\t\tfilterString=\"doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter\"\n\t\t\t\t\twidth=\"29\" height=\"29\"\tx=\"486\" y=\"-22\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"doctor.Back1\" \n\t\t\t\t\tresourceLink=\"asset.core.describeBackground_style06\" scaleGridString=\"10,10,70,30\"\n\t\t\t\t\twidth=\"528\" height=\"300\" x=\"-2\" y=\"4\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"doctor.Back2\" \n\t\t\t\t\tresourceLink=\"asset.core.InputBack_Style_01\" scaleGridString=\"10,10,125,7\"\n\t\t\t\t\twidth=\"530\" height=\"48\" x=\"-3\" y=\"304\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.IconButton\" stylename=\"doctor.CopyBtn\" \n\t\t\t\t\tbackStyle=\"asset.core.ButtonStyle_03\" \n\t\t\t\t\ticonStyle=\"asset.loading.DoctorCopy\" iconInnerRectString=\"32,48,10,22,13\"\n\t\t\t\t\tfilterString=\"doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter\"\n\t\t\t\t\tx=\"407\" y=\"308\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.IconButton\" stylename=\"doctor.StartBtn\" \n\t\t\t\t\tbackStyle=\"asset.core.ButtonStyle_03\" \n\t\t\t\t\ticonStyle=\"asset.loading.DoctorStart\" iconInnerRectString=\"18,77,10,22,13\"\n\t\t\t\t\tfilterString=\"doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter\"\n\t\t\t\t\tx=\"407\" y=\"308\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.Describetxt\" \n\t\t\t\t\ttextFormatStyle=\"doctor.Describetxt_t\" filterString=\"doctor.normal_f\" autoSize=\"none\"\n\t\t\t\t\twordWrap=\"true\" multiline=\"true\" width=\"392\" height=\"40\" x=\"4\" y=\"318\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.Image\" stylename=\"doctor.LoaderItemBack\"\n\t\t\t\t\tresourceLink=\"asset.loading.Spliceline\"\n\t\t\t\t\twidth=\"495\" height=\"30\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.LoaderItemName\" \n\t\t\t\t\ttextFormatStyle=\"doctor.Describetxt_t\" filterString=\"doctor.normal_f\" autoSize=\"none\"\n\t\t\t\t\twidth=\"170\" height=\"22\" x=\"10\" y=\"6\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.LoaderItemProgress\" \n\t\t\t\t\ttextFormatStyle=\"doctor.Describetxt_t\" filterString=\"doctor.normal_f\" autoSize=\"none\"\n\t\t\t\t\twidth=\"145\" height=\"22\" x=\"160\" y=\"6\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.LoaderItemSpeed\" \n\t\t\t\t\ttextFormatStyle=\"doctor.Describetxt_t\" filterString=\"doctor.normal_f\" autoSize=\"none\"\n\t\t\t\t\twidth=\"142\" height=\"22\" x=\"280\" y=\"6\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"doctor.LoaderItemResule\" \n\t\t\t\t\ttextFormatStyle=\"doctor.LoaderItemResule_t\" filterString=\"doctor.normal_f\" autoSize=\"none\"\n\t\t\t\t\twidth=\"144\" height=\"22\" x=\"345\" y=\"6\" isAutoFitLength=\"true\"\n\t\t\t\t/>\t\t\t\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.container.VBox\" stylename=\"doctor.Vbox\"\n\t\t\t\t\tspacing=\"0\"\n\t\t\t\t/>\t\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"doctor.Scrollbar02_Back\" \n\t\t\t\t\tresourceLink=\"asset.core.scrollbar02_bg\" \n\t\t\t\t\twidth=\"15\" height=\"24\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"doctor.scrollbar02_stepAsset\" \n\t\t\t\t\tresourceLink=\"asset.core.scrollbar02_step\" scaleGridString=\"0,18,21,36\"\n\t\t\t\t\twidth=\"21\" height=\"56\"\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"doctor.Scrollbar02_Step\" \n\t\t\t\t\tbackStyle=\"doctor.scrollbar02_stepAsset\" displacement=\"false\"\n\t\t\t\t\tfilterString=\"doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter\"\n\t\t\t\t\twidth=\"21\" height=\"56\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"doctor.Scrollbar02_Up\" \n\t\t\t\t\tbackStyle=\"asset.core.scrollbar02_up\" displacement=\"false\"\n\t\t\t\t\twidth=\"11\" height=\"10\"\t\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"doctor.Scrollbar02_Down\" \n\t\t\t\t\tbackStyle=\"asset.core.scrollbar02_down\"  displacement=\"false\"\n\t\t\t\t\twidth=\"11\" height=\"10\"\t\n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.Scrollbar\" stylename=\"doctor.VScrollbar02\" \n\t\t\t\t\ttrackStyle=\"doctor.Scrollbar02_Back\" \n\t\t\t\t\tthumbStyle=\"doctor.Scrollbar02_Step\" \n\t\t\t\t\tdecreaseButtonStyle=\"doctor.Scrollbar02_Up\" \n\t\t\t\t\tincreaseButtonStyle=\"doctor.Scrollbar02_Down\" \n\t\t\t\t\ttrackInnerRectString=\"3,3,0,0,0\" \n\t\t\t\t\tthumbAreaInnerRectString=\"0,0,10,10,0\" \n\t\t\t\t\tdecreaseButtonInnerRectString=\"10,10,0,0,9\" \n\t\t\t\t\tincreaseButtonInnerRectString=\"10,10,0,0,10\" \n\t\t\t\t\torientation=\"0\" thumbMinSize=\"38\" \n\t\t\t\t\twidth=\"21\" height=\"200\" \n\t\t\t\t/>\n\t\t\t\t<component classname=\"com.pickgliss.ui.controls.ScrollPanel\" stylename=\"doctor.ScrollPanel\"\n\t\t\t\t\tvScrollbarStyle=\"doctor.VScrollbar02\"\n\t\t\t\t\tvScrollbarInnerRectString=\"21,0,0,0,3\"\n\t\t\t\t\tviewportInnerRectString=\"0,22,0,0,0\" \n\t\t\t\t\tvScrollProxy='0'\n\t\t\t\t\tx=\"1\" y=\"7\" width=\"524\" height=\"290\" \n\t\t\t\t/>\n\t\t\t</xml>")
			;
         $.C("com.pickgliss.ui.ComponentFactory").Instance.setup(_loc1_);
      }
  }
  $.meta(__DoctorStyle, "doctor.DoctorStyle", []);
  return __DoctorStyle;
}
deps["doctor.DoctorStyle"] = ["com.pickgliss.ui.ComponentFactory"];

defs["doctor.view.LoaderInfoItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __LoaderInfoItem extends __Base {
    static $fields(self) {
    self._back = null;
    self._loaderName = null;
    self._loaderProgress = null;
    self._loaderSpeed = null;
    self._resule = null;
    self._path = null;
    self._name = null;
    self._startTime = 0;
    self._completeBack = null;
    self._loader = null;
    self._request = null;
    }
    constructor(param1, param2) {
         super();
         this._path = param2;
         this._name = param1;
         this._loader = new ($.C("flash.net.URLLoader"))();
         this.initView();
         this.initEvent();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,507,29);
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemBack");
         this._loaderName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemName");
         this._loaderProgress = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemProgress");
         this._loaderSpeed = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemSpeed");
         this._resule = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemResule");
         this.addChild(this._back);
         this.addChild(this._loaderName);
         this.addChild(this._loaderProgress);
         this.addChild(this._loaderSpeed);
         this.addChild(this._resule);
         this._loaderName.text = this._name;
         this._loaderProgress.text = "Progresso: Aguardando...";
      }
    initEvent() {
         this._loader.addEventListener("complete",$.bind(this, "__onDataLoadComplete"));
         this._loader.addEventListener("progress",$.bind(this, "__onProgress"));
         this._loader.addEventListener("httpStatus",$.bind(this, "__onStatus"));
         this._loader.addEventListener("ioError",$.bind(this, "__onIOError"));
      }
    removeEvent() {
         this._loader.removeEventListener("complete",$.bind(this, "__onDataLoadComplete"));
         this._loader.removeEventListener("progress",$.bind(this, "__onProgress"));
         this._loader.removeEventListener("httpStatus",$.bind(this, "__onStatus"));
         this._loader.removeEventListener("ioError",$.bind(this, "__onIOError"));
      }
    start(param1) {
         this._completeBack = param1;
         this._startTime = $.C("flash.utils.getTimer")();
         var _loc2_ = new ($.C("flash.net.URLVariables"))();
         _loc2_["ran"] = Math.random();
         this._loader.dataFormat = "binary";
         this._request = new ($.C("flash.net.URLRequest"))(this._path);
         this._request.method = "GET";
         this._request.data = _loc2_;
         this._loader.load(this._request);
      }
    stop() {
         this.removeEvent();
         try
         {
            this._loader.close();
         }
         catch(e)
         {
         }
      }
    __onStatus(param1) {
      }
    __onIOError(param1) {
      }
    __onDataLoadComplete(param1) {
         this.removeEvent();
         this._loaderProgress.text = "Progresso: 100%";
         var _loc2_ = this._loader.bytesTotal * 1000 / (($.C("flash.utils.getTimer")() - this._startTime) * 1024);
         if(_loc2_ > 1000)
         {
            this._loaderSpeed.text = (_loc2_ / 1024).toFixed(2) + "MB/s";
         }
         else
         {
            this._loaderSpeed.text = _loc2_.toFixed(2) + "KB/s";
         }
         this._resule.text = "Verificando arquivo...";
         try
         {
            this._loader.close();
         }
         catch(err)
         {
         }
         if(this._loader.data.length == 0)
         {
            this._completeBack("Arquivo" + this._path + "Extensão é zero");
            this._completeBack = null;
            return;
         }
         this.check($.as(this._loader.data, $.C("flash.utils.ByteArray")));
      }
    __onProgress(param1) {
         var _loc2_ = (param1.bytesLoaded / param1.bytesTotal * 100).toFixed(2);
         this._loaderProgress.text = "Progresso：" + _loc2_ + "%";
         this._resule.text = "Carregando arquivo...";
      }
    check(param1) {
         var _loc2_ = $.C("com.pickgliss.ui.ComponentSetting").getUrlMd5(this._path);
         if($.C("com.pickgliss.ui.ComponentSetting").checkNeedAnalyzeMd5(_loc2_))
         {
            if($.C("com.pickgliss.ui.ComponentSetting").compareMD5(param1,_loc2_))
            {
               this._completeBack("Arquivo" + this._path + "Sucedido");
               this._resule.text = "Verificação do arquivo sucedido";
            }
            else
            {
               this._completeBack("Arquivo" + this._path + "Falha");
               this._resule.text = "Falha na verificação do arquivo";
            }
         }
         else
         {
            this._completeBack("Arquivo" + this._path + "Falha");
            this._resule.text = "Falha na verificação do arquivo";
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderName);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderProgress);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderSpeed);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resule);
         this._back = null;
         this._loaderName = null;
         this._loaderProgress = null;
         this._loaderSpeed = null;
         this._resule = null;
         this._path = null;
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__LoaderInfoItem, "doctor.view.LoaderInfoItem", ["Disposeable", "IManualSize"]);
  return __LoaderInfoItem;
}
deps["doctor.view.LoaderInfoItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Rectangle", "flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables", "flash.utils.ByteArray", "flash.utils.getTimer"];

defs["notice.NoticeFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __NoticeFrame extends __Base {
    static $fields(self) {
    self._back = null;
    self._scrollPanel = null;
    self._content = null;
    self._updateTitleBg = null;
    self._updateContent = null;
    self._dateAsset = null;
    self._updateDate = null;
    self._updatePreTitleBg = null;
    self._updatePre = null;
    self._titleSp1 = null;
    self._titleSp2 = null;
    self._contain = null;
    self._itemArr1 = null;
    self._itemArr2 = null;
    self._loader = null;
    self.xml = null;
    }
    constructor() {
         super();
      }
    load() {
         if(!this._loader)
         {
            this._loader = new ($.C("flash.net.URLLoader"))();
         }
         this._loader.dataFormat = "text";
         var _loc1_ = new ($.C("flash.net.URLVariables"))();
         _loc1_["rnd"] = Math.random();
         var _loc2_ = new ($.C("flash.net.URLRequest"))($.C("com.pickgliss.ui.ComponentSetting").VERTION_PATH);
         _loc2_.data = _loc1_;
         this._loader.addEventListener("complete",$.bind(this, "__completehandler"));
         this._loader.load(_loc2_);
      }
    __completehandler(param1) {
         if(this.isDie)
         {
            return;
         }
         this.xml = $.XML(($.as(param1.currentTarget, $.C("flash.net.URLLoader"))).data);
         param1.currentTarget.removeEventListener("complete",$.bind(this, "__completehandler"));
         this.initView();
         this.refreshView();
         this.initEvent();
      }
    initView() {
         this.titleText = "Anúncio de Atualização";
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("noticeFrame.UpdateBroadCastBack");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastScroll");
         this._updateDate = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastDate");
         this._dateAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateDateAsset");
         this._updateTitleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         this._updateContent = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateContentAsset");
         this._updatePre = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdatePreAsset");
         this._updatePreTitleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         this._contain = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._contain.spacing = 10;
         this.addToContent(this._back);
         this.addToContent(this._scrollPanel);
         this._titleSp1 = new ($.C("flash.display.Sprite"))();
         this._titleSp2 = new ($.C("flash.display.Sprite"))();
         this._itemArr1 = [];
         this._itemArr2 = [];
         this._titleSp1.addChild(this._updateTitleBg);
         this._titleSp1.addChild(this._updateContent);
         this._titleSp1.addChild(this._dateAsset);
         this._titleSp1.addChild(this._updateDate);
         this._titleSp2.addChild(this._updatePreTitleBg);
         this._titleSp2.addChild(this._updatePre);
         this._scrollPanel.setView(this._contain);
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         if(this._loader)
         {
            this._loader.removeEventListener("complete",$.bind(this, "__completehandler"));
         }
      }
    __frameResponseHandler(param1) {
         switch(param1.responseCode)
         {
            case 0:
               this.dispose();
               break;
            case 1:
               this.dispose();
         }
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,635,407);
      }
    refreshView() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc9_ = null;
         if(!this.xml)
         {
            return;
         }
         try
         {
            this._updateDate.text = this.xml.$descendants("time")[0].toString();
         }
         catch(e)
         {
            _loc1_ = "Não há comunicado de atualização";
            this.dispose();
            return;
         }
         var _loc6_ = "";
         var _loc8_ = "";
         var _loc7_ = /\/n/g;
         for (_loc4_ of $.values(this.xml.curContent.$descendants("item")))
         {
            if(_loc4_)
            {
               _loc2_ = new ($.C("flash.display.Sprite"))();
            }
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!this.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!this.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc6_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc6_ = _loc6_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!this.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc6_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc6_ = _loc6_.replace(_loc7_,"<br/>");
            _loc5_.htmlText = _loc6_;
            _loc5_.height = _loc5_.textHeight + 4;
            _loc2_.addChild(_loc5_);
            this._itemArr1.push(_loc2_);
         }
         if(!this.isNullOrEmpty(_loc6_))
         {
            this._contain.addChild(this._titleSp1);
            for (_loc2_ of $.values(this._itemArr1))
            {
               this._contain.addChild(_loc2_);
            }
         }
         for (_loc4_ of $.values(this.xml.nextContent.$descendants("item")))
         {
            if(_loc4_)
            {
               _loc3_ = new ($.C("flash.display.Sprite"))();
            }
            _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!this.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!this.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc8_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc8_ = _loc8_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!this.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc8_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc8_ = _loc8_.replace(_loc7_,"<br/>");
            _loc9_.htmlText = _loc8_;
            _loc9_.height = _loc9_.textHeight + 4;
            _loc3_.addChild(_loc9_);
            this._itemArr2.push(_loc3_);
         }
         if(!this.isNullOrEmpty(_loc8_))
         {
            this._contain.addChild(this._titleSp2);
            for (_loc3_ of $.values(this._itemArr2))
            {
               this._contain.addChild(_loc3_);
            }
         }
         this._scrollPanel.invalidateViewport();
      }
    isNullOrEmpty(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return param1 == null || param1 == "";
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dateAsset);
         this._dateAsset = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updateDate);
         this._updateDate = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updateContent);
         this._updateContent = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updatePre);
         this._updatePre = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleSp1);
         this._titleSp1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleSp2);
         this._titleSp2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemArr1);
         this._itemArr1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemArr2);
         this._itemArr2 = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__NoticeFrame, "notice.NoticeFrame", ["IManualSize"]);
  return __NoticeFrame;
}
deps["notice.NoticeFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Rectangle", "flash.net.URLLoader", "flash.net.URLRequest", "flash.net.URLVariables"];

defs["notice.NoticeStyle"] = function define($) {
  const __Base = $.Object;
  class __NoticeStyle extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         var _loc1_ = $.XML("<xml name=\"noticestyle\">\n\t\t\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"notice.FrameTitleText_t\" args=\"Arial,15,0xFFDD83,true\" letterSpacing=\"2\"/>\n\t\t\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"notice.Describetxt_t\" args=\"Arial,12,0xffffff,\" letterSpacing=\"2\"/>\n\t\t\t\t\t\t\t<set type=\"flash.text.TextFormat\" stylename=\"notice.UpdateBroadCastDate_t\" args=\"Arial,14,0xffeb79,,,,,,left\"  letterSpacing=\"1\"/>\n\t\t\t\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"notice.FrameTitile_g\" args=\"0x000000,1,5,5,5\" />\n\t\t\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"notice.DefaultFilter\" args=\"1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0\" />\n\t\t\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"notice.LightFilter\" args=\"1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0\"/>\n\t\t\t\t\t\t\t<set type=\"flash.filters.ColorMatrixFilter\" stylename=\"notice.GrayFilter\" args=\"0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0\"/>\n\t\t\t\t\t\t\t<set type=\"flash.filters.GlowFilter\" stylename=\"notice.normal_f\" args=\"0x000000,1,5,5,3\" />\t\t\n\t\t\t\t\t\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"notice.FrameTitleText\" \n\t\t\t\t\t\t\t\ttextFormatStyle=\"notice.FrameTitleText_t\" filterString=\"notice.FrameTitile_g\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"notice.CloseBtn\" \n\t\t\t\t\t\t\t\tbackStyle=\"asset.core.closeBtn_style01\" filterString=\"notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter\"\n\t\t\t\t\t\t\t\tdisplacement='false' isFollowMouse = \"false\"\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.Scale9CornerImage\" stylename=\"notice.FrameBackgoundBase1\" \n                                resourceLink=\"asset.core.style02_scale9bg1,asset.core.style02_scale9bg2,asset.core.style02_scale9bg3,asset.core.style02_scale9bg4,asset.core.style02_scale9bg5,asset.core.style02_scale9bg6,asset.core.style02_scale9bg7,asset.core.style02_scale9bg8,asset.core.style02_scale9bg9\"\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.Image\" stylename=\"notice.FrameTitleImage1\" \n\t\t\t\t\t\t\t\tresourceLink=\"asset.core.frameTitleImage2\"\n\t\t\t\t\t\t\t\twidth=\"229\" height=\"17\"\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.MutipleImage\" stylename=\"notice.FrameBg1\"\n\t\t\t\t\t\t\t\tresourceLink=\"notice.FrameBackgoundBase1\" imageRectString=\"-18|-15|0|23|0\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"notice.NoticeFrame\" stylename=\"notice.NoticeFrame\"\n\t\t\t\t\t\t\t\tclosestyle=\"notice.CloseBtn\" titleStyle=\"notice.FrameTitleText\" backStyle=\"notice.FrameBg1\" \n\t\t\t\t\t\t\t\tcloseInnerRectString=\"29,3,12,29,14\" \n\t\t\t\t\t\t\t\tmoveInnerRectString=\"0,30,0,45,1\" titleOuterRectPosString=\"0,12,1\"\n\t\t\t\t\t\t\t\tmoveEnable=\"false\" enterEnable=\"true\" escEnable=\"true\"\n\t\t\t\t\t\t\t\tcontainerX=\"8\" containerY=\"45\"\n\t\t\t\t\t\t\t\twidth=\"635\" height=\"407\"\n\t\t\t\t\t\t\t/>\n                            <custom classname=\"asset.timestory.UpdateBroadCastBack\" stylename=\"noticeFrame.UpdateBroadCastBack\" \n                                x='0' y=\"0\" width=\"618\" height=\"324\"\n                            />\n                            <component classname=\"com.pickgliss.ui.controls.ScrollPanel\" stylename=\"noticeFrame.UpdateBroadCastScroll\" \n\t\t\t                    vScrollbarStyle=\"notice.VScrollbar03\"\n\t\t\t                    vScrollbarInnerRectString=\"16,0,0,0,3\"\n\t\t\t                    viewportInnerRectString=\"0,0,0,0,5\"\n\t\t\t                    vScrollProxy=\"0\" vUnitIncrement=\"5\"\n\t\t\t                    width=\"618\" height=\"324\"\n\t\t                    />\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.Scrollbar\" stylename=\"notice.VScrollbar03\" \n\t\t\t\t\t\t\t\ttrackStyle=\"notice.Scrollbar03_Back\" \n\t\t\t\t\t\t\t\tthumbStyle=\"notice.Scrollbar03_Step\" \n\t\t\t\t\t\t\t\tdecreaseButtonStyle=\"notice.Scrollbar03_Up\" \n\t\t\t\t\t\t\t\tincreaseButtonStyle=\"notice.Scrollbar03_Down\" \n                                trackInnerRectString=\"0,0,0,0,0\" \n\t\t\t                    thumbAreaInnerRectString=\"1,1,16,16,0\" \n\t\t\t                    decreaseButtonInnerRectString=\"16,16,0,0,9\" \n\t\t\t                    increaseButtonInnerRectString=\"16,16,0,0,10\" \n\t\t\t                    orientation=\"0\" thumbMinSize=\"23\" \n\t\t\t                    width=\"16\" height=\"200\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"notice.Scrollbar03_Back\" \n\t\t\t\t\t\t\t\tresourceLink=\"asset.core.scrollbar03_bg\" \n\t\t\t\t\t\t\t\twidth=\"15\" height=\"24\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.image.ScaleBitmapImage\" stylename=\"notice.scrollbar03_stepAsset\" \n\t\t\t\t\t\t\t\tresourceLink=\"asset.core.scrollbar03_step\" scaleGridString=\"0,13,13,26\"\n\t\t\t\t\t\t\t\twidth=\"13\" height=\"36\"\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"notice.Scrollbar03_Step\" \n\t\t\t\t\t\t\t\tbackStyle=\"notice.scrollbar03_stepAsset\" displacement=\"false\"\n\t\t\t\t\t\t\t\tfilterString=\"notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter\"\n\t\t\t\t\t\t\t\twidth=\"13\" height=\"36\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"notice.Scrollbar03_Up\" \n\t\t\t\t\t\t\t\tbackStyle=\"asset.core.scrollbar03_up\" displacement=\"false\"\n\t\t\t\t\t\t\t\twidth=\"16\" height=\"16\"\t\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.BaseButton\" stylename=\"notice.Scrollbar03_Down\" \n\t\t\t\t\t\t\t\tbackStyle=\"asset.core.scrollbar03_down\"  displacement=\"false\"\n\t\t\t\t\t\t\t\twidth=\"16\" height=\"16\"\t\n\t\t\t\t\t\t\t/>\n\t\t\t\t\t\t\t<component classname=\"com.pickgliss.ui.controls.ScrollPanel\" stylename=\"notice.ScrollPanel\"\n\t\t\t\t\t\t\t\tvScrollbarStyle=\"notice.VScrollbar02\"\n\t\t\t\t\t\t\t\tvScrollbarInnerRectString=\"21,0,0,0,3\"\n\t\t\t\t\t\t\t\tviewportInnerRectString=\"0,22,0,0,0\" \n\t\t\t\t\t\t\t\tvScrollProxy='0'\n\t\t\t\t\t\t\t\tx=\"1\" y=\"7\" width=\"524\" height=\"290\" \n\t\t\t\t\t\t\t/>\n\t\t\t\t\t        <component classname=\"com.pickgliss.ui.text.FilterFrameText\" stylename=\"noticeFrame.UpdateBroadCastDate\"\t\n\t\t\t\t\t\t\t\ttextFormatStyle=\"notice.UpdateBroadCastDate_t\" filterString=\"notice.normal_f\"\n\t\t\t\t\t\t\t\tautoSize=\"none\"  width=\"220\" height=\"20\"\n\t\t\t\t\t\t\t\tx=\"345\" y=\"7\"\n \t\t\t\t\t\t\t/>\n\t\t\t\t\t\t</xml>")
			;
         $.C("com.pickgliss.ui.ComponentFactory").Instance.setup(_loc1_);
      }
  }
  $.meta(__NoticeStyle, "notice.NoticeStyle", []);
  return __NoticeStyle;
}
deps["notice.NoticeStyle"] = ["com.pickgliss.ui.ComponentFactory"];
