package theseusgodhead.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseus.war.item.TheseusWarMaxItem;
   import theseusgodhead.item.GodheadUpStarCell;
   import yishi.datas.templates.TheseusSlateUpgradeInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   
   public class TheseusGodheadUpgradeView extends Sprite
   {
      
      private var _currentLevelTxt:FilterFrameText;
      
      private var _nextLevelTxt:FilterFrameText;
      
      private var _costTxt:FilterFrameText;
      
      private var _costTxt1:FilterFrameText;
      
      private var _costicon:Bitmap;
      
      private var _costicon1:Bitmap;
      
      private var _hasicon:Bitmap;
      
      private var _confirmBtn:TextButton;
      
      public var _star2Cell:GodheadUpStarCell;
      
      private var _bg:Bitmap;
      
      private var _arrow:MovieClip;
      
      public var _inf2sbg:Bitmap;
      
      public var _allNum:FilterFrameText;
      
      public var _numBack:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _maxItem:TheseusWarMaxItem;
      
      private var _nextZyLvTxt1:FilterFrameText;
      
      private var _nextZyLvTxt2:FilterFrameText;
      
      private var _nextZyLvTxt3:FilterFrameText;
      
      private var _maxZyLvArr:Array;
      
      private var _nextMaxZyNumArr:Array;
      
      private var _maxZyLvTxt1:FilterFrameText;
      
      private var _maxZyLvTxt2:FilterFrameText;
      
      private var _maxZyLvTxt3:FilterFrameText;
      
      private var _nextIncreaseTxt1:FilterFrameText;
      
      private var _nextIncreaseTxt2:FilterFrameText;
      
      private var _nextIncreaseTxt3:FilterFrameText;
      
      private var _nextIncreaseArr:Array;
      
      private var _pos:int;
      
      private var _currentLevel:int;
      
      public function TheseusGodheadUpgradeView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,300);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("TheseusGodHeaduplvbg");
         _bg.y = -50;
         _bg.x = 40;
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.star2Row");
         _arrow.x = 148;
         _inf2sbg = ComponentFactory.Instance.creatBitmap("asset.theseus.war.inf2sbg");
         _inf2sbg.x = 11;
         _inf2sbg.height = 90;
         _currentLevelTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbaglvtxt");
         _currentLevelTxt.x = 50;
         _currentLevelTxt.y = 165;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _nextLevelTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbaglvtxt");
         _nextLevelTxt.x = 250;
         _nextLevelTxt.y = 165;
         _costTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _costTxt1.x = 210;
         _costicon = ComponentFactory.Instance.creatBitmap("TheseusGodHeaduplvmat1");
         _costicon.x = 105;
         _costicon.y = 275;
         _costicon.visible = false;
         _costicon1 = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GoldIcoImg");
         _costicon1.x = 185;
         _costicon1.y = 275;
         _costicon1.visible = false;
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _costTxt.x = 140;
         _hasicon = ComponentFactory.Instance.creatBitmap("TheseusGodHeaduplvmat1");
         _allNum = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.allNum");
         _numBack = ComponentFactory.Instance.creatBitmap("asset.poseridon.numBack");
         _hasicon.x = 235;
         _hasicon.y = -30;
         _numBack.x = 265;
         _numBack.y = -28;
         _numBack.width = 84;
         _allNum.x = 233;
         _allNum.y = -25;
         addChild(_numBack);
         addChild(_allNum);
         addChild(_hasicon);
         _maxZyLvTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4MaxGradeTxt");
         _maxZyLvArr = [_maxZyLvTxt1,_maxZyLvTxt2,_maxZyLvTxt3];
         _nextZyLvTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextZyLvTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusWAr.gz4NextMaxGradeTxt");
         _nextMaxZyNumArr = [_nextZyLvTxt1,_nextZyLvTxt2,_nextZyLvTxt3];
         _nextIncreaseTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _nextIncreaseTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _nextIncreaseTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagcosttxt");
         _nextIncreaseTxt1.y = _nextZyLvTxt1.y = _maxZyLvTxt1.y = 188;
         _nextIncreaseTxt2.y = _nextZyLvTxt2.y = _maxZyLvTxt2.y = 208;
         _nextIncreaseTxt3.y = _maxZyLvTxt3.y = _nextZyLvTxt3.y = 228;
         _maxZyLvTxt1.x = _maxZyLvTxt2.x = _maxZyLvTxt3.x = 40;
         _nextZyLvTxt1.x = _nextZyLvTxt2.x = _nextZyLvTxt3.x = 205;
         _nextIncreaseTxt1.x = _nextIncreaseTxt2.x = _nextIncreaseTxt3.x = 320;
         _nextIncreaseArr = [_nextIncreaseTxt1,_nextIncreaseTxt2,_nextIncreaseTxt3];
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("TheseusGodheadUpgradeView.confirmBtn");
         _confirmBtn.text = LanguageMgr.GetTranslation("theseusgodhead.upgrade.confirm");
         _confirmBtn.enable = false;
         addChild(_bg);
         addChild(_inf2sbg);
         addChild(_arrow);
         addChild(_nameTxt);
         _nameTxt.y = 135;
         addChild(_currentLevelTxt);
         addChild(_nextLevelTxt);
         addChild(_costTxt);
         addChild(_costTxt1);
         addChild(_costicon);
         addChild(_costicon1);
         addChild(_confirmBtn);
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensifyMaxItem");
         _maxItem.redStr(LanguageMgr.GetTranslation("theseusgodhead.txt13"));
         _maxItem.titleStr(LanguageMgr.GetTranslation("army.stone.fullLV"));
         _maxItem.updateTitlePos(44,2);
         _maxItem.x = 45;
         _maxItem.y = 340;
         addChild(_maxItem);
         _maxItem.visible = false;
         _star2Cell = ComponentFactory.Instance.creatCustomObject("theseusgodhead.item.GodheadUpStarCell");
         addChild(_star2Cell);
         _star2Cell.x = 135;
         _star2Cell.y = 45;
         addChild(_maxZyLvTxt1);
         addChild(_maxZyLvTxt2);
         addChild(_maxZyLvTxt3);
         addChild(_nextZyLvTxt1);
         addChild(_nextZyLvTxt2);
         addChild(_nextZyLvTxt3);
         addChild(_nextIncreaseTxt1);
         addChild(_nextIncreaseTxt2);
         addChild(_nextIncreaseTxt3);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("EventGodheadInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("EventGodheadInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
         _star2Cell.addEventListener("click",moutUpdateHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("EventGodheadInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("EventGodheadInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
         _star2Cell.removeEventListener("click",moutUpdateHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_,true);
         }
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.upgradeSlate(_star2Cell.data.stoneId);
      }
      
      public function updateUI(param1:int, param2:Boolean = false) : void
      {
         var _loc10_:String = null;
         var _loc22_:String = null;
         var _loc16_:int = 0;
         var _loc14_:int = 0;
         var _loc23_:int = 0;
         var _loc20_:int = 0;
         var _loc18_:int = 0;
         var _loc15_:String = null;
         var _loc12_:String = null;
         var _loc19_:String = null;
         var _loc17_:String = null;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:String = null;
         var _loc24_:TheseusGodheadStoneInfo = TheseussoulManager.Instance.modelGodhead.getStoneById(param1);
         _currentLevelTxt.text = LanguageMgr.GetTranslation("theseusgodhead.upgrade.currentLevel",_loc24_.level);
         _star2Cell.data = _loc24_;
         _nameTxt.text = _loc24_.name;
         var _loc7_:TheseusSlateUpgradeInfo = _loc24_.getUpgradeTemplateInfo();
         var _loc5_:Array = [];
         for(var _loc21_:String in _loc24_.baseAttributes)
         {
            _loc5_.push(_loc21_);
         }
         _costTxt.text = "";
         _costicon.visible = false;
         _costicon1.visible = false;
         _costTxt1.text = "";
         var _loc11_:int = 0;
         var _loc13_:int = int(_loc7_ ? _loc7_.Item.split(",")[0] : 0);
         _allNum.text = GoodsManager.instance.getGoodsNumByTempId(_loc13_) + "";
         if(_loc24_.level < _loc24_.maxLevel)
         {
            _currentLevelTxt.x = 60;
            _maxZyLvTxt1.x = _maxZyLvTxt2.x = _maxZyLvTxt3.x = 46;
            _maxItem.visible = false;
            _confirmBtn.visible = true;
            _confirmBtn.enable = true;
            _nextLevelTxt.visible = true;
            _nextLevelTxt.text = LanguageMgr.GetTranslation("theseusgodhead.upgrade.currentLevel",_loc24_.level + 1);
            _arrow.visible = true;
            _costTxt.text = _loc7_ ? _loc7_.Item.split(",")[1] + "" : "";
            _costicon.visible = true;
            if(_loc7_ && _loc7_.Consume > 0)
            {
               _costicon1.visible = true;
               _costTxt1.text = _loc7_.Consume + "";
            }
            _loc11_ = 0;
            while(_loc11_ < 3 && _loc11_ < _loc5_.length)
            {
               _loc10_ = _loc5_[_loc11_];
               _loc22_ = AttributeUtils.getAttributeName(_loc10_);
               _loc16_ = int(_loc24_.baseAttributes[_loc10_] || 0);
               _loc14_ = int(_loc24_.levelUpAttributes[_loc10_] || 0);
               _loc23_ = _loc16_ + _loc24_.level * _loc14_;
               _loc20_ = _loc16_ + (_loc24_.level + 1) * _loc14_;
               _loc18_ = _loc14_;
               _loc15_ = _loc22_ + "  +" + _loc23_;
               (_maxZyLvArr[_loc11_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc15_,"#e4d29c");
               _loc12_ = _loc22_ + "  +" + _loc20_;
               (_nextMaxZyNumArr[_loc11_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc12_,"#e4d29c");
               _loc19_ = "+" + _loc18_;
               (_nextIncreaseArr[_loc11_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc19_,"#00ff00");
               _loc11_++;
            }
            _loc11_ = int(_loc5_.length);
            while(_loc11_ < 3)
            {
               (_maxZyLvArr[_loc11_] as FilterFrameText).text = "";
               (_nextMaxZyNumArr[_loc11_] as FilterFrameText).text = "";
               (_nextIncreaseArr[_loc11_] as FilterFrameText).text = "";
               _loc11_++;
            }
         }
         else
         {
            _arrow.visible = false;
            _currentLevelTxt.x = 160;
            _maxItem.visible = true;
            _confirmBtn.visible = false;
            _nextLevelTxt.visible = false;
            _maxZyLvTxt1.x = _maxZyLvTxt2.x = _maxZyLvTxt3.x = 121;
            if(_loc24_.star == _loc24_.maxStar)
            {
               _maxItem.isShowRedTip = false;
            }
            _loc11_ = 0;
            while(_loc11_ < 3 && _loc11_ < _loc5_.length)
            {
               _loc17_ = _loc5_[_loc11_];
               _loc6_ = AttributeUtils.getAttributeName(_loc17_);
               _loc3_ = int(_loc24_.baseAttributes[_loc17_] || 0);
               _loc8_ = int(_loc24_.levelUpAttributes[_loc17_] || 0);
               _loc9_ = _loc3_ + _loc24_.level * _loc8_;
               _loc4_ = _loc6_ + "  +" + _loc9_;
               (_maxZyLvArr[_loc11_] as FilterFrameText).htmlText = AttributeUtils.getColorStr(_loc4_,"#e4d29c");
               (_nextMaxZyNumArr[_loc11_] as FilterFrameText).text = "";
               (_nextIncreaseArr[_loc11_] as FilterFrameText).text = "";
               _loc11_++;
            }
            _loc11_ = int(_loc5_.length);
            while(_loc11_ < 3)
            {
               (_maxZyLvArr[_loc11_] as FilterFrameText).text = "";
               (_nextMaxZyNumArr[_loc11_] as FilterFrameText).text = "";
               (_nextIncreaseArr[_loc11_] as FilterFrameText).text = "";
               _loc11_++;
            }
         }
      }
      
      private function updateEmpty() : void
      {
         _confirmBtn.enable = false;
         _star2Cell.data = null;
         _nextIncreaseTxt1.text = "";
         _nextIncreaseTxt2.text = "";
         _nextIncreaseTxt3.text = "";
         _nameTxt.text = "";
         _maxZyLvTxt1.text = "";
         _maxZyLvTxt2.text = "";
         _maxZyLvTxt3.text = "";
         _nextZyLvTxt1.text = "";
         _nextZyLvTxt2.text = "";
         _nextZyLvTxt3.text = "";
         _maxItem.visible = false;
         _confirmBtn.visible = true;
         _confirmBtn.enable = false;
         _costTxt.text = "";
         _costicon.visible = false;
         _costicon1.visible = false;
         _costTxt1.text = "";
         _currentLevelTxt.text = "";
         _nextLevelTxt.text = "";
      }
      
      private function moutUpdateHandler(param1:MouseEvent) : void
      {
         updateEmpty();
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         updateEmpty();
      }
      
      private function _onSlateUpdate(param1:NotificationEvent) : void
      {
         if(_star2Cell.data && _star2Cell.data.stoneId > 0)
         {
            updateUI(_star2Cell.data.stoneId);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inf2sbg);
         _inf2sbg = null;
         ObjectUtils.disposeObject(_maxZyLvTxt1);
         _maxZyLvTxt1 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt2);
         _maxZyLvTxt2 = null;
         ObjectUtils.disposeObject(_maxZyLvTxt3);
         _maxZyLvTxt3 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt1);
         _nextZyLvTxt1 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt2);
         _nextZyLvTxt2 = null;
         ObjectUtils.disposeObject(_nextZyLvTxt3);
         _nextZyLvTxt3 = null;
         ObjectUtils.disposeObject(_nextIncreaseTxt1);
         _nextIncreaseTxt1 = null;
         ObjectUtils.disposeObject(_nextIncreaseTxt2);
         _nextIncreaseTxt2 = null;
         ObjectUtils.disposeObject(_nextIncreaseTxt3);
         _nextIncreaseTxt3 = null;
         ObjectUtils.disposeObject(_currentLevelTxt);
         _currentLevelTxt = null;
         ObjectUtils.disposeObject(_nextLevelTxt);
         _nextLevelTxt = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
      }
   }
}

