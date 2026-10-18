package theseus.warFrame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.TheseussoulManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.warFrame.item.WarframeMetrailCell;
   import theseus.warFrame.item.WarframeQhCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleDictionary;
   
   public class WarframeTransformationView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      public var _gz4from:WarframeQhCell;
      
      public var _gz4MTxt:FilterFrameText;
      
      public var _gz4SuccTxt:FilterFrameText;
      
      public var _gzGNameTxt:FilterFrameText;
      
      public var _gz4Btn:IconButton;
      
      public var _gz4Metrial1:WarframeMetrailCell;
      
      public var _gz4Metrial2:WarframeMetrailCell;
      
      public var _gz4Metrial3:WarframeMetrailCell;
      
      public var _maxZyNumTxt:FilterFrameText;
      
      public var _gz4ProfiefTxt:FilterFrameText;
      
      private var _maxZyLvArr:Array;
      
      private var _nextMaxZyNumArr:Array;
      
      private var _maxZyLvTxt1:FilterFrameText;
      
      private var _maxZyLvTxt2:FilterFrameText;
      
      private var _maxZyLvTxt3:FilterFrameText;
      
      private var _maxZyLvTxt4:FilterFrameText;
      
      private var _maxZyLvTxt5:FilterFrameText;
      
      public var _nextMaxZyNumTxt:FilterFrameText;
      
      public var _gz4ProfienTxt:FilterFrameText;
      
      private var _nextZyLvTxt1:FilterFrameText;
      
      private var _nextZyLvTxt2:FilterFrameText;
      
      private var _nextZyLvTxt3:FilterFrameText;
      
      private var _nextZyLvTxt4:FilterFrameText;
      
      private var _nextZyLvTxt5:FilterFrameText;
      
      private var _arrow:MovieClip;
      
      private var _maxItem:TheseusWarMaxItem;
      
      private var _glvTxt:FilterFrameText;
      
      private var _currPutNum:int = 0;
      
      private var _totalBoxf:VBox;
      
      private var _totalBoxn:VBox;
      
      private var _metriaBox:HBox;
      
      private var _metriaArr:Array;
      
      public var _allNum:FilterFrameText;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      public var _mainPriceIcon:ScaleFrameImage;
      
      private var _lastChooseNum:int;
      
      private var _hasNums:int;
      
      private var _lastreform:int = -1;
      
      public function WarframeTransformationView()
      {
         super();
         initView();
         initEvent();
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.intensify.gzTxtBg");
         _gz4from = ComponentFactory.Instance.creatCustomObject("ui.warFrame.gz4next");
         _gz4from.y = -30;
         _gzGNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuswar.gz4GNameTxt");
         _gz4MTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4MTxt");
         _gz4Btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.sp4Btn");
         _gz4Metrial1 = ComponentFactory.Instance.creatCustomObject("ui.warFrame.gz4Metrial");
         _gz4Metrial2 = ComponentFactory.Instance.creatCustomObject("ui.warFrame.gz4Metrial");
         _gz4Metrial3 = ComponentFactory.Instance.creatCustomObject("ui.warFrame.gz4Metrial");
         _gz4SuccTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4SuccTxt");
         _maxZyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4fNameTxt");
         _nextMaxZyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4nNameTxt");
         _gz4ProfiefTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4ProfiefTxt");
         _gz4ProfienTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gz4ProfienTxt");
         _maxZyLvTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt4 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt5 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvArr = [_maxZyLvTxt1,_maxZyLvTxt2,_maxZyLvTxt3,_maxZyLvTxt4,_maxZyLvTxt5];
         _nextZyLvTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt4 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt5 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextMaxZyNumArr = [_nextZyLvTxt1,_nextZyLvTxt2,_nextZyLvTxt3,_nextZyLvTxt4,_nextZyLvTxt5];
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.gz4Row");
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.gzMaxItem");
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseus.warframe.gzFull"));
         _maxItem.redStr("");
         _maxItem.updateTitlePos(44,2);
         _glvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.gzGaiLvTxt");
         _totalBoxf = ComponentFactory.Instance.creatComponentByStylename("tips.WarframeTransformationView");
         _totalBoxn = ComponentFactory.Instance.creatComponentByStylename("tips.WarframeTransformationView");
         _metriaBox = ComponentFactory.Instance.creatComponentByStylename("WarframeTransformationView.vbox");
         addChild(_bg);
         addChild(_gzGNameTxt);
         addChild(_gz4MTxt);
         addChild(_gz4Btn);
         _metriaBox.addChild(_gz4Metrial1);
         _metriaBox.addChild(_gz4Metrial2);
         _metriaBox.addChild(_gz4Metrial3);
         _metriaArr = [_gz4Metrial1,_gz4Metrial2,_gz4Metrial3];
         addChild(_metriaBox);
         addChild(_gz4SuccTxt);
         addChild(_arrow);
         addChild(_maxItem);
         addChild(_glvTxt);
         addChild(_totalBoxf);
         addChild(_totalBoxn);
         _totalBoxf.addChild(_gz4ProfiefTxt);
         _totalBoxf.addChild(_maxZyNumTxt);
         _totalBoxf.addChild(_maxZyLvTxt1);
         _totalBoxf.addChild(_maxZyLvTxt2);
         _totalBoxf.addChild(_maxZyLvTxt3);
         _totalBoxf.addChild(_maxZyLvTxt4);
         _totalBoxf.addChild(_maxZyLvTxt5);
         _totalBoxn.addChild(_gz4ProfienTxt);
         _totalBoxn.addChild(_nextMaxZyNumTxt);
         _totalBoxn.addChild(_nextZyLvTxt1);
         _totalBoxn.addChild(_nextZyLvTxt2);
         _totalBoxn.addChild(_nextZyLvTxt3);
         _totalBoxn.addChild(_nextZyLvTxt4);
         _totalBoxn.addChild(_nextZyLvTxt5);
         addChild(_gz4from);
         _maxItem.hideTbg();
         _gz4from.funType = 3;
         _gz4from.isNeedMediator = true;
         _maxItem.visible = false;
         _gz4Btn.enable = false;
         _gz4MTxt.text = LanguageMgr.GetTranslation("theesus.war.intensifyCL") + ":";
         _allNum = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.allNum");
         _mainPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.mainPriceIcon");
         addChild(_allNum);
         addChild(_mainPriceIcon);
         _mainPriceIcon.scaleX = _mainPriceIcon.scaleY = 0.8;
         _mainPriceIcon.visible = false;
         _allNum.text = "";
         _mainPriceIcon.x = 140;
         _mainPriceIcon.y = 295;
         _allNum.x = 110;
         _allNum.y = 286;
         _mainPriceIcon.setFrame(1);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("EventWarFrameInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("EventWarFrameInsPutOut",outUpdateHandler);
         _gz4Btn.addEventListener("click",gzClickHandler);
         TheseussoulManager.Instance.addEventListener("OP_WarEQUIP_STRENGTHENSTR",updateHandler);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("OP_WarEQUIP_STRENGTHENSTR",updateHandler);
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutOut",outUpdateHandler);
         _gz4Btn.removeEventListener("click",gzClickHandler);
      }
      
      private function gzPrecenthandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(_gz4from.data)
         {
            _currPutNum = _loc2_[3];
            _lastChooseNum = _currPutNum;
            _glvTxt.htmlText;
         }
      }
      
      private function updateId(param1:WarFrameItemInfo) : void
      {
         var _loc2_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc3_:WarFrameItemInfo in _loc2_)
         {
            if(_loc3_.strengthen == param1.strengthen && _loc3_.templateId == param1.templateId && _loc3_.reform == param1.reform + 1 && _loc3_.isEquip == param1.isEquip)
            {
               updateUI(_loc3_.id);
            }
         }
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_gz4from.data && _loc2_ == 6)
         {
            updateId(_gz4from.data);
         }
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _gz4Btn.enable = false;
         _gz4from.data = null;
         _gz4Metrial1.data = null;
         _gz4Metrial2.data = null;
         _gz4Metrial3.data = null;
         _maxZyNumTxt.text = "";
         _gzGNameTxt.text = "";
         _nextMaxZyNumTxt.text = "";
         _gz4ProfiefTxt.text = "";
         _gz4ProfienTxt.text = "";
         _maxZyLvTxt1.text = "";
         _maxZyLvTxt2.text = "";
         _maxZyLvTxt3.text = "";
         _maxZyLvTxt4.text = "";
         _maxZyLvTxt5.text = "";
         _nextZyLvTxt1.text = "";
         _nextZyLvTxt2.text = "";
         _nextZyLvTxt3.text = "";
         _nextZyLvTxt4.text = "";
         _nextZyLvTxt5.text = "";
         _allNum.text = "";
         _maxItem.visible = false;
         _glvTxt.text = "";
         _lastreform = -1;
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function gzClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         if(_gz4from.data)
         {
            _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            alertConfirm();
         }
      }
      
      private function alertConfirm() : void
      {
         TheseussoulManager.Instance.doWarFrameParam(6,_gz4from.data.id);
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
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc12_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc14_:Array = null;
         var _loc11_:Array = null;
         var _loc15_:GoodsInfo = null;
         var _loc18_:WarFrameItemInfo = TheseussoulManager.Instance.model.getItemInfo(param1);
         TheseussoulManager.Instance.warsoulModel.currWarInsSelectInfo = _loc18_;
         _gz4from.data = _loc18_;
         var _loc6_:String = GoodsHelp.getGoodColorString(_loc18_.reform);
         var _loc4_:String = AttributeUtils.getColorStr(_loc18_.warTempInfo.TemplateName,_loc6_,false);
         _gzGNameTxt.htmlText = _loc4_;
         var _loc16_:String = LanguageMgr.GetTranslation("WarframeTransformationView.txt1",_loc18_.warReformTempInfo.StrengthenLimit);
         _maxZyNumTxt.htmlText = AttributeUtils.getColorStr(_loc16_,"#ffffff");
         var _loc17_:Array = _loc18_.warReformTempInfo.Attr.split("|");
         _loc7_ = 0;
         while(_loc7_ < _loc17_.length)
         {
            _loc9_ = _loc17_[_loc7_].split(",");
            _loc10_ = _loc9_[0];
            _loc12_ = AttributeUtils.getZjAttributeName(_loc10_);
            _loc16_ = _loc12_ + "  +" + _loc9_[1];
            (_maxZyLvArr[_loc7_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc16_,"#ffffff");
            _loc7_++;
         }
         if(_loc18_.warReformTempInfo.Attr == "")
         {
            _loc7_ = 0;
            while(_loc7_ < 5)
            {
               _loc10_ = (_loc7_ + 1).toString();
               _loc12_ = AttributeUtils.getZjAttributeName(_loc10_);
               _loc16_ = _loc12_ + "  +0";
               (_maxZyLvArr[_loc7_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc16_,"#ffffff");
               _loc7_++;
            }
         }
         var _loc5_:String = GoodsHelp.getGoodColorString(_loc18_.reform);
         var _loc13_:String = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc18_.reform),_loc5_,false);
         _gz4ProfiefTxt.htmlText = _loc13_;
         _gz4Metrial1.visible = true;
         _gz4Metrial2.visible = true;
         _gz4Metrial3.visible = true;
         _nextMaxZyNumTxt.visible = true;
         _nextZyLvTxt1.visible = true;
         _nextZyLvTxt2.visible = true;
         _nextZyLvTxt3.visible = true;
         _nextZyLvTxt4.visible = true;
         _nextZyLvTxt5.visible = true;
         _gz4ProfienTxt.visible = true;
         if(_loc18_.warReformTempInfo.Cost)
         {
            _loc8_ = _loc18_.warReformTempInfo.Cost.split("|");
            _loc14_ = _loc8_.pop().split(",");
            _loc11_ = [];
            if(_loc14_[1] > 0)
            {
               _mainPriceIcon.visible = true;
               _gz4Btn.enable = _currencyInfo.poseidonCoin.amount < _loc14_[1];
               _allNum.text = _loc14_[1] + "";
            }
            else
            {
               _allNum.text = "";
               _mainPriceIcon.visible = false;
               _gz4Btn.enable = true;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc8_.length)
            {
               _loc15_ = new GoodsInfo();
               _loc15_.templateId = _loc8_[_loc7_].split(",")[0];
               _loc15_.count = _loc8_[_loc7_].split(",")[1];
               _metriaArr[_loc7_].data = _loc15_;
               if(!_metriaArr[_loc7_].isEnough)
               {
                  _gz4Btn.enable = false;
               }
               _loc7_++;
            }
         }
         var _loc3_:WarFrameItemInfo = _loc18_.clone();
         _loc3_.reform += 1;
         if(_loc3_.warReformTempInfo)
         {
            _loc16_ = LanguageMgr.GetTranslation("WarframeTransformationView.txt1",_loc3_.warReformTempInfo.StrengthenLimit);
            _nextMaxZyNumTxt.htmlText = AttributeUtils.getColorStr(_loc16_,"#ffea04");
            _loc17_ = _loc3_.warReformTempInfo.Attr.split("|");
            _loc7_ = 0;
            while(_loc7_ < _loc17_.length)
            {
               _loc9_ = _loc17_[_loc7_].split(",");
               _loc10_ = _loc9_[0];
               _loc12_ = AttributeUtils.getZjAttributeName(_loc10_);
               _loc16_ = _loc12_ + "  +" + _loc9_[1];
               (_nextMaxZyNumArr[_loc7_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc16_,"#ffffff");
               _loc7_++;
            }
            _loc5_ = GoodsHelp.getGoodColorString(_loc3_.reform);
            _loc13_ = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc3_.reform),_loc5_,false);
            _gz4ProfienTxt.htmlText = _loc13_;
            _maxItem.visible = false;
         }
         else
         {
            _maxItem.visible = true;
            _allNum.text = "";
            _nextZyLvTxt1.visible = false;
            _nextZyLvTxt2.visible = false;
            _nextZyLvTxt3.visible = false;
            _nextZyLvTxt4.visible = false;
            _nextZyLvTxt5.visible = false;
            _nextMaxZyNumTxt.visible = false;
            _nextMaxZyNumArr.visible = false;
            _gz4ProfienTxt.visible = false;
            _mainPriceIcon.visible = false;
            _gz4Btn.enable = false;
            _loc7_ = 0;
            while(_loc7_ < _metriaArr.length)
            {
               _metriaArr[_loc7_].data = null;
               _loc7_++;
            }
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
         ObjectUtils.disposeObject(_gz4Metrial1);
         _gz4Metrial1 = null;
         ObjectUtils.disposeObject(_gz4Metrial2);
         _gz4Metrial2 = null;
         ObjectUtils.disposeObject(_gz4Metrial3);
         _gz4Metrial3 = null;
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
         ObjectUtils.disposeObject(_maxZyLvTxt1);
         _maxZyLvTxt1 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt2);
         _maxZyLvTxt2 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt3);
         _maxZyLvTxt3 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt4);
         _maxZyLvTxt4 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt5);
         _maxZyLvTxt5 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt1);
         _nextZyLvTxt1 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt2);
         _nextZyLvTxt2 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt3);
         _nextZyLvTxt3 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt4);
         _nextZyLvTxt4 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt5);
         _nextZyLvTxt5 = null;
         ObjectUtils.disposeObject(_totalBoxf);
         _totalBoxf = null;
         ObjectUtils.disposeObject(_totalBoxn);
         _totalBoxn = null;
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

