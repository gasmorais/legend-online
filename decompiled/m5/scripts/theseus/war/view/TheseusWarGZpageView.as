package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusCCItem;
   import theseus.war.item.TheseusWarIntensifyCell;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.war.item.TheseusWarMetrailCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.WarSoulStarTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class TheseusWarGZpageView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      public var _gz4from:TheseusWarIntensifyCell;
      
      public var _gz4MTxt:FilterFrameText;
      
      public var _gz4SuccTxt:FilterFrameText;
      
      public var _gzGNameTxt:FilterFrameText;
      
      public var _gz4Btn:IconButton;
      
      public var _gz4Metrial:TheseusWarMetrailCell;
      
      public var _maxZyNumTxt:FilterFrameText;
      
      public var _gz4ProfiefTxt:FilterFrameText;
      
      private var _maxZyLvTxt:FilterFrameText;
      
      public var _nextMaxZyNumTxt:FilterFrameText;
      
      public var _gz4ProfienTxt:FilterFrameText;
      
      private var _nextZyLvTxt:FilterFrameText;
      
      private var _arrow:MovieClip;
      
      private var _chooseItem:TheseusCCItem;
      
      private var _maxItem:TheseusWarMaxItem;
      
      private var _glvTxt:FilterFrameText;
      
      private var _currPutNum:int = 0;
      
      private var _returnNoChange:int;
      
      private var _returnFial:int;
      
      private var _lastChooseNum:int;
      
      private var _hasNums:int;
      
      private var _lastreform:int = -1;
      
      public function TheseusWarGZpageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.intensify.gzTxtBg");
         _gz4from = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.gz4from");
         _gzGNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4GNameTxt");
         _gz4MTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4MTxt");
         _gz4Btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4Btn");
         _gz4Metrial = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.gz4Metrial");
         _gz4SuccTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4SuccTxt");
         _maxZyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4fNameTxt");
         _nextMaxZyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4nNameTxt");
         _gz4ProfiefTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4ProfiefTxt");
         _gz4ProfienTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4ProfienTxt");
         _maxZyLvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4MaxGradeTxt");
         _nextZyLvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4NextMaxGradeTxt");
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.gz4Row");
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.gzMaxItem");
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseus.war.gzFull"));
         _maxItem.redStr(LanguageMgr.GetTranslation("theseus.war.needGzflg"));
         _maxItem.updateTitlePos(44,2);
         _chooseItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.gzTheseusCCItem");
         _glvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gzGaiLvTxt");
         addChild(_bg);
         addChild(_gz4from);
         addChild(_gzGNameTxt);
         addChild(_gz4MTxt);
         addChild(_gz4Btn);
         addChild(_gz4Metrial);
         addChild(_gz4SuccTxt);
         addChild(_maxZyNumTxt);
         addChild(_nextMaxZyNumTxt);
         addChild(_gz4ProfiefTxt);
         addChild(_gz4ProfienTxt);
         addChild(_maxZyLvTxt);
         addChild(_nextZyLvTxt);
         addChild(_arrow);
         addChild(_maxItem);
         addChild(_chooseItem);
         addChild(_glvTxt);
         _maxItem.hideTbg();
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 3;
         _gz4from.funType = 3;
         _gz4from.isNeedMediator = true;
         _maxItem.visible = false;
         _gz4Btn.enable = false;
         _gz4MTxt.text = LanguageMgr.GetTranslation("theseus.war.intensifyMetrial") + ":";
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         NotificationManager.instance.addEventListener("Event.GzCountPrecent",gzPrecenthandler);
         _gz4Btn.addEventListener("click",gzClickHandler);
         _chooseItem.addEventListener("click",chooseClickHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",updateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.GzCountPrecent",gzPrecenthandler);
         _gz4Btn.removeEventListener("click",gzClickHandler);
         _chooseItem.removeEventListener("click",chooseClickHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",updateHandler);
      }
      
      private function gzPrecenthandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(_gz4from.data)
         {
            _currPutNum = _loc2_[3];
            _lastChooseNum = _currPutNum;
            _returnNoChange = _loc2_[1];
            _returnFial = _loc2_[2];
            _chooseItem.updateProgess(_hasNums,_lastChooseNum);
            _glvTxt.htmlText = LanguageMgr.GetTranslation("theseus.war.gz.gailv",_loc2_[0],_returnNoChange,_returnFial);
         }
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_gz4from.data && _loc2_ == 13)
         {
            updateUI(_gz4from.data.id);
         }
      }
      
      private function chooseClickHandler(param1:MouseEvent) : void
      {
         if(_chooseItem.data && _gz4from.data)
         {
            FrameControllerManager.instance.openControllerByInfo("theseussoul",6,[_gz4from.data,_lastChooseNum]);
         }
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _gz4Btn.enable = false;
         _gz4from.data = null;
         _gz4Metrial.data = null;
         _chooseItem.data = null;
         _chooseItem.isChoose = true;
         _maxZyNumTxt.text = "";
         _gzGNameTxt.text = "";
         _nextMaxZyNumTxt.text = "";
         _gz4ProfiefTxt.text = "";
         _gz4ProfienTxt.text = "";
         _maxZyLvTxt.text = "";
         _nextZyLvTxt.text = "";
         _maxItem.visible = false;
         _glvTxt.text = "";
         _lastreform = -1;
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function gzClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(_gz4from.data)
         {
            _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            if(_gz4from.data.warStartempInfo.MaxReform <= _gz4from.data.reform)
            {
               _loc3_ = LanguageMgr.GetTranslation("theseus.war.gzToadyTip2");
               SharedManagerHelper.ins.needAlert("theseus.war.view.TheseusWarGZpageView2",alertConfirm,_loc2_,_loc3_);
            }
            else if(_returnFial > 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("theseus.war.gzToadyTip",_returnFial);
               SharedManagerHelper.ins.needAlert("theseus.war.view.TheseusWarGZpageView",alertConfirm,_loc2_,_loc3_);
            }
            else
            {
               alertConfirm();
            }
         }
      }
      
      private function alertConfirm() : void
      {
         TheseussoulManager.Instance.doWarsoulParam(13,_currPutNum,_gz4from.data.id);
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_,true);
         }
      }
      
      private function updateUI(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:TheseusWarsoulItemInfo = null;
         var _loc14_:WarSoulStarTempInfo = null;
         var _loc15_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = _loc15_;
         _gz4from.data = _loc15_;
         var _loc6_:String = GoodsHelp.getGoodColorString(_loc15_.warTempInfo.Profile);
         var _loc4_:String = AttributeUtils.getColorStr(_loc15_.warTempInfo.Name,_loc6_,false);
         _gzGNameTxt.htmlText = _loc4_;
         var _loc13_:String = LanguageMgr.GetTranslation("theseus.war.zhangyiNum",_loc15_.warReformTempInfo.MaxWarpath);
         _maxZyNumTxt.htmlText = AttributeUtils.getColorStr(_loc13_,"#d8d5b9");
         _loc13_ = LanguageMgr.GetTranslation("theseus.war.zhangyiMaxLv",_loc15_.warReformTempInfo.MaxRageGrades);
         _maxZyLvTxt.htmlText = AttributeUtils.getColorStr(_loc13_,"#d8d5b9");
         var _loc5_:String = GoodsHelp.getGoodColorString(_loc15_.reform);
         var _loc11_:String = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc15_.reform),_loc5_,false);
         _gz4ProfiefTxt.htmlText = _loc11_;
         _gz4Metrial.visible = true;
         _chooseItem.visible = true;
         _nextMaxZyNumTxt.visible = true;
         _nextZyLvTxt.visible = true;
         _gz4ProfienTxt.visible = true;
         var _loc7_:GoodsInfo = new GoodsInfo();
         _loc7_.templateId = _loc15_.warReformTempInfo.NeedStone;
         _chooseItem.data = _loc7_;
         _hasNums = GoodsManager.instance.getGoodsNumByTempId(_loc7_.templateId);
         var _loc8_:int = int(_loc7_.templateInfo.Property2);
         var _loc9_:int = Math.ceil(_loc15_.warReformTempInfo.FailProbability / _loc8_);
         if(param2)
         {
            _lastChooseNum = _loc9_;
         }
         else if(_lastreform != _loc15_.reform)
         {
            _lastChooseNum = _loc9_;
         }
         _lastreform = _loc15_.reform;
         _loc9_ = _lastChooseNum;
         _chooseItem.updateProgess(_hasNums,_loc9_);
         _currPutNum = _hasNums;
         if(_hasNums > _loc9_)
         {
            _currPutNum = _loc9_;
         }
         _returnNoChange = _loc15_.warReformTempInfo.UnchangedProbability + _currPutNum * _loc8_;
         if(_returnNoChange > 100)
         {
            _returnNoChange = 100;
         }
         _returnFial = _loc15_.warReformTempInfo.FailProbability - _currPutNum * _loc8_;
         if(_returnFial < 0)
         {
            _returnFial = 0;
         }
         _glvTxt.htmlText = LanguageMgr.GetTranslation("theseus.war.gz.gailv",_loc15_.warReformTempInfo.SuccessProbability,_returnNoChange,_returnFial);
         var _loc10_:Array = _loc15_.warReformTempInfo.NeedItem.split(",");
         var _loc12_:GoodsInfo = new GoodsInfo();
         _loc12_.templateId = int(_loc10_[0]);
         _loc12_.count = int(_loc10_[1]);
         _gz4Metrial.data = _loc12_;
         _gz4Btn.enable = _gz4Metrial.isEnough;
         if(!_loc15_.warStartempInfo)
         {
            return;
         }
         if(_loc15_.warStartempInfo.MaxReform > _loc15_.reform)
         {
            _loc3_ = _loc15_.clone();
            _loc3_.reform += 1;
            _loc13_ = LanguageMgr.GetTranslation("theseus.war.zhangyiNum",_loc3_.warReformTempInfo.MaxWarpath);
            _nextMaxZyNumTxt.htmlText = AttributeUtils.getColorStr(_loc13_,"#ffea04");
            _loc13_ = LanguageMgr.GetTranslation("theseus.war.zhangyiMaxLv",_loc3_.warReformTempInfo.MaxRageGrades);
            _nextZyLvTxt.htmlText = AttributeUtils.getColorStr(_loc13_,"#ffea04");
            _loc5_ = GoodsHelp.getGoodColorString(_loc3_.reform);
            _loc11_ = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc3_.reform),_loc5_,false);
            _gz4ProfienTxt.htmlText = _loc11_;
            _maxItem.visible = false;
         }
         else
         {
            _maxItem.visible = true;
            _loc14_ = TempleteManager.instance.warsoulStarCate.getTemp(_loc15_.warSoulId,_loc15_.star + 1);
            if(_loc14_)
            {
               _maxItem.isShowRedTip = true;
            }
            else
            {
               _maxItem.isShowRedTip = false;
            }
            _nextMaxZyNumTxt.visible = false;
            _nextZyLvTxt.visible = false;
            _gz4ProfienTxt.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_gz4from && _gz4from.data)
         {
            _gz4from.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_gz4from.data.id);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gz4from);
         _gz4from = null;
         ObjectUtils.disposeObject(_gz4MTxt);
         _gz4MTxt = null;
         ObjectUtils.disposeObject(_gz4Btn);
         _gz4Btn = null;
         ObjectUtils.disposeObject(_gz4Metrial);
         _gz4Metrial = null;
         ObjectUtils.disposeObject(_gz4SuccTxt);
         _gz4SuccTxt = null;
         ObjectUtils.disposeObject(_maxZyNumTxt);
         _maxZyNumTxt = null;
         ObjectUtils.disposeObject(_nextMaxZyNumTxt);
         _nextMaxZyNumTxt = null;
         ObjectUtils.disposeObject(_gz4ProfiefTxt);
         _gz4ProfiefTxt = null;
         ObjectUtils.disposeObject(_gz4ProfienTxt);
         _gz4ProfienTxt = null;
         ObjectUtils.disposeObject(_gzGNameTxt);
         _gzGNameTxt = null;
         ObjectUtils.disposeObject(_maxZyLvTxt);
         _maxZyLvTxt = null;
         ObjectUtils.disposeObject(_nextZyLvTxt);
         _nextZyLvTxt = null;
         ObjectUtils.disposeViolentMc(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_maxItem);
         _maxItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
   }
}

