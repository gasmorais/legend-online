package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusCCItem;
   import theseus.war.item.TheseusWarIntensifyCell;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.war.item.TheseusWarMetrailCell;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.WarSoulStarTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class TheseusWarStarPageView extends Sprite
   {
      
      public var _star2Cell:TheseusWarIntensifyCell;
      
      public var _inf2sbg:Bitmap;
      
      public var _star2NameTxt:FilterFrameText;
      
      public var _star2RewardTx:FilterFrameText;
      
      public var _star2HBox:HBox;
      
      public var _star2Btn:IconButton;
      
      private var _arrow:MovieClip;
      
      private var _currstarContaint:HBox;
      
      private var _nextstarContaint:HBox;
      
      private var _maxItem:TheseusWarMaxItem;
      
      private var _mItemList:Vector.<TheseusWarMetrailCell>;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _currStar:int;
      
      private var _opingId:int;
      
      private var MIN_STAR:int;
      
      private var MAX_STAR:int;
      
      public function TheseusWarStarPageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarMetrailCell = null;
         var _loc2_:int = 0;
         _star2Cell = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.star2Cell");
         _inf2sbg = ComponentFactory.Instance.creatBitmap("asset.theseus.war.inf2sbg");
         _star2NameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.star2NameTxt");
         _star2RewardTx = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.star2RewardTx");
         _star2HBox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.star2HBox");
         _star2Btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.star2Btn");
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.star2Row");
         _currstarContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCurrStarHbox");
         _nextstarContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warNextStarHbox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.StarDeleteButton");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.StarAddButton");
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.starMaxItem");
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseus.war.starMax"));
         _maxItem.updateRightBitPos(235,0);
         addChild(_star2Cell);
         addChild(_inf2sbg);
         addChild(_star2NameTxt);
         addChild(_star2RewardTx);
         addChild(_star2HBox);
         addChild(_star2Btn);
         addChild(_arrow);
         addChild(_currstarContaint);
         addChild(_nextstarContaint);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_maxItem);
         _maxItem.visible = false;
         _preBtn.visible = false;
         _nextBtn.visible = false;
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 2;
         _star2Cell.funType = 2;
         _star2Cell.isNeedMediator = true;
         _mItemList = new Vector.<TheseusWarMetrailCell>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new TheseusWarMetrailCell();
            _mItemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _star2Btn.enable = false;
         _star2RewardTx.text = LanguageMgr.GetTranslation("theseus.war.intensifyStarT");
         _star2RewardTx.visible = false;
      }
      
      private function initEvent() : void
      {
         _star2Btn.addEventListener("click",clickHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",updateHandler);
         _preBtn.addEventListener("click",preBtnHandler);
         _nextBtn.addEventListener("click",nextBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _star2Btn.removeEventListener("click",clickHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",updateHandler);
         _preBtn.addEventListener("click",preBtnHandler);
         _nextBtn.addEventListener("click",nextBtnHandler);
      }
      
      private function preBtnHandler(param1:MouseEvent) : void
      {
         updateADBtns(-1);
      }
      
      private function nextBtnHandler(param1:MouseEvent) : void
      {
         updateADBtns(1);
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_star2Cell.data && _loc2_ == 11)
         {
            updateUI(_star2Cell.data.id);
         }
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _arrow.visible = true;
         _maxItem.visible = false;
         _star2HBox.visible = false;
         _star2RewardTx.visible = false;
         _nextstarContaint.visible = false;
         _currstarContaint.visible = false;
         _star2Btn.enable = false;
         _star2Cell.data = null;
         _star2NameTxt.visible = false;
         _preBtn.visible = false;
         _nextBtn.visible = false;
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_);
         }
      }
      
      private function updateUI(param1:int) : void
      {
         _star2Btn.enable = false;
         var _loc4_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         _currStar = _loc4_.star;
         _opingId = _loc4_.warSoulId;
         MIN_STAR = _currStar;
         MAX_STAR = _loc4_.warTempInfo.MaxStar;
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = _loc4_;
         _star2Cell.data = _loc4_;
         var _loc3_:String = GoodsHelp.getGoodColorString(_loc4_.warTempInfo.Profile);
         var _loc2_:String = AttributeUtils.getColorStr(_loc4_.warTempInfo.Name,_loc3_,false);
         _star2NameTxt.htmlText = _loc2_;
         _currstarContaint.visible = true;
         showStar(_loc4_.star,_currstarContaint);
         if(_loc4_.star >= MAX_STAR)
         {
            _nextstarContaint.visible = false;
            _maxItem.visible = true;
            _arrow.visible = false;
            _maxItem.visible = true;
            _star2HBox.visible = false;
            _star2RewardTx.visible = false;
            _nextstarContaint.visible = false;
            _star2NameTxt.visible = false;
            _currstarContaint.x = 207;
            _preBtn.visible = false;
            _nextBtn.visible = false;
         }
         else
         {
            _arrow.visible = true;
            _maxItem.visible = false;
            _star2HBox.visible = true;
            _star2RewardTx.visible = true;
            _nextstarContaint.visible = true;
            _star2NameTxt.visible = true;
            _preBtn.visible = true;
            _nextBtn.visible = true;
            _currstarContaint.x = 132;
            updateADBtns(0);
         }
      }
      
      private function updateADBtns(param1:int) : void
      {
         _currStar += param1;
         if(_currStar < MAX_STAR - 1)
         {
            _nextBtn.enable = true;
         }
         else
         {
            _currStar = MAX_STAR - 1;
            _nextBtn.enable = false;
         }
         if(_currStar > MIN_STAR)
         {
            _preBtn.enable = true;
         }
         else
         {
            _currStar = MIN_STAR;
            _preBtn.enable = false;
         }
         showStar(_currStar + 1,_nextstarContaint);
         refreshStarMetrials();
      }
      
      private function get isEnough() : Boolean
      {
         var _loc1_:TheseusCCItem = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_star2HBox.numChildren);
         var _loc3_:Boolean = true;
         if(_loc2_ == 0)
         {
            _loc3_ = false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _star2HBox.getChildAt(_loc4_) as TheseusCCItem;
            if(_loc1_ && !_loc1_.isEnougth)
            {
               _loc3_ = false;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function refreshStarMetrials() : void
      {
         var _loc6_:WarSoulStarTempInfo = null;
         var _loc14_:Array = null;
         var _loc7_:String = null;
         var _loc16_:Array = null;
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc17_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc15_:GoodsInfo = null;
         var _loc1_:TheseusWarMetrailCell = null;
         var _loc5_:int = 0;
         var _loc13_:int = _currStar;
         var _loc10_:Array = [];
         var _loc2_:Dictionary = new Dictionary();
         _loc8_ = MIN_STAR;
         while(_loc8_ <= _loc13_)
         {
            _loc6_ = TempleteManager.instance.warsoulStarCate.getTemp(_opingId,_loc8_);
            if(_loc6_ && _loc6_.NeedWarSoul)
            {
               _loc14_ = _loc6_.NeedWarSoul.split("|");
               _loc9_ = 0;
               while(_loc9_ < _loc14_.length)
               {
                  _loc16_ = _loc14_[_loc9_].split(",");
                  _loc11_ = int(_loc16_[0]);
                  _loc12_ = int(_loc16_[1]);
                  _loc7_ = "" + _loc11_;
                  if(_loc2_[_loc7_] == null)
                  {
                     _loc10_.push(_loc7_);
                     _loc2_[_loc7_] = _loc12_;
                  }
                  else
                  {
                     _loc2_[_loc7_] += _loc12_;
                  }
                  _loc9_++;
               }
            }
            _loc8_++;
         }
         _star2HBox.beginChanges();
         _star2HBox.removeAllChild();
         var _loc3_:Boolean = true;
         _loc9_ = 0;
         while(_loc9_ < _loc10_.length)
         {
            _loc15_ = new GoodsInfo();
            _loc12_ = int(_loc2_[_loc11_ = int(_loc10_[_loc9_])]);
            _loc15_.templateId = _loc11_;
            _loc15_.count = _loc12_;
            _loc5_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc11_));
            _loc1_ = _mItemList[_loc9_];
            _loc1_.data = _loc15_;
            _star2HBox.addChild(_loc1_);
            _loc3_ &&= _loc5_ >= _loc12_;
            _loc9_++;
         }
         _star2Btn.enable = _loc3_;
         _star2HBox.commitChanges();
         _loc2_ = null;
         if(_nextBtn.enable && !isEnough)
         {
            _nextBtn.enable = false;
         }
      }
      
      private function showStar(param1:int, param2:HBox) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = (param1 - 1) / 5 + 1;
         ObjectUtils.disposeAllChildren(param2);
         param2.beginChanges();
         var _loc5_:int = _loc7_ * 5;
         var _loc8_:int = (_loc7_ - 1) * 5;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc4_ = _loc8_ + _loc6_;
            if(param1 > _loc4_ && _loc7_ > 0)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.profie.star" + _loc7_);
               param2.addChild(_loc3_);
            }
            _loc6_++;
         }
         param2.commitChanges();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_star2Cell.data)
         {
            TheseussoulManager.Instance.doWarsoulParam(11,_currStar + 1,_star2Cell.data.id,-1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_star2Cell && _star2Cell.data)
         {
            _star2Cell.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_star2Cell.data.id);
         }
         ObjectUtils.disposeObject(_star2Cell);
         _star2Cell = null;
         ObjectUtils.disposeObject(_inf2sbg);
         _inf2sbg = null;
         ObjectUtils.disposeObject(_star2NameTxt);
         _star2NameTxt = null;
         ObjectUtils.disposeObject(_star2RewardTx);
         _star2RewardTx = null;
         ObjectUtils.disposeObject(_star2HBox);
         _star2HBox = null;
         ObjectUtils.disposeObject(_star2Btn);
         _star2Btn = null;
         ObjectUtils.disposeViolentMc(_arrow);
         _arrow = null;
         ObjectUtils.disposeViolentMc(_maxItem);
         _maxItem = null;
         ObjectUtils.disposeObject(_currstarContaint);
         _currstarContaint = null;
         ObjectUtils.disposeViolentMc(_nextstarContaint);
         _nextstarContaint = null;
         ObjectUtils.disposeViolentMc(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeViolentMc(_nextBtn);
         _nextBtn = null;
         LogicUtils.disposeDisplayCollection(_mItemList);
         _mItemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
   }
}

