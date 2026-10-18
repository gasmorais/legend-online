package theseusgodhead.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.war.item.TheseusWarMetrailCell;
   import theseusgodhead.item.GodheadUpStarCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.TheseusSlateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusGodheadStarUpView extends Sprite
   {
      
      private var _currstarContaint:HBox;
      
      private var _nextstarContaint:HBox;
      
      private var _costTxt:FilterFrameText;
      
      public var _star2Cell:GodheadUpStarCell;
      
      public var _star3Cell:GodheadUpStarCell;
      
      public var _materCell:GodheadUpStarCell;
      
      private var _maxItem:TheseusWarMaxItem;
      
      private var _mItemList:Vector.<TheseusWarMetrailCell>;
      
      private var _arrow:MovieClip;
      
      public var _star2Btn:IconButton;
      
      public var _star2HBox:HBox;
      
      public var _star2NameTxt:FilterFrameText;
      
      public var _shibanNumTxt:FilterFrameText;
      
      private var _pos:int;
      
      private var _currentStar:int;
      
      private var _bg:Bitmap;
      
      public function TheseusGodheadStarUpView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,300);
      }
      
      private function refreshStarMetrials() : void
      {
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarMetrailCell = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("TheseusGodHeaduplvbg");
         addChild(_bg);
         _bg.x = 45;
         _bg.y = 40;
         _star2Btn = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusGodHeadupstarBtn.star2Btn");
         addChild(_star2Btn);
         _currstarContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCurrStarHbox");
         _nextstarContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warNextStarHbox");
         _currstarContaint.x = _nextstarContaint.x = 180;
         _currstarContaint.y = 120;
         _nextstarContaint.y = 312;
         addChild(_nextstarContaint);
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensifyMaxItem");
         _maxItem.redStr("");
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseusgodhead.txt14"));
         _maxItem.updateTitlePos(44,2);
         _maxItem.x = 45;
         _maxItem.y = 340;
         addChild(_maxItem);
         _maxItem.visible = false;
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.star2Row");
         _arrow.x = 223;
         _arrow.y = 167;
         _arrow.rotation = 90;
         addChild(_arrow);
         _star2HBox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.star2HBox");
         _star2HBox.spacing = 98;
         _star2HBox.x = 289;
         _star2HBox.y = 127;
         addChild(_star2HBox);
         _star2NameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.star2NameTxt");
         _star2NameTxt.x = 107;
         _star2NameTxt.y = 137;
         addChild(_star2NameTxt);
         _materCell = ComponentFactory.Instance.creatCustomObject("theseusgodhead.item.GodheadUpStarCell");
         _materCell.x = 19;
         _materCell.y = 132;
         addChild(_materCell);
         _shibanNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.star2NameTxt");
         _shibanNumTxt.x = 5;
         _shibanNumTxt.y = 182;
         _shibanNumTxt.textColor = 16777215;
         addChild(_shibanNumTxt);
         _star2Cell = ComponentFactory.Instance.creatCustomObject("theseusgodhead.item.GodheadUpStarCell");
         _star2Cell.x = 135;
         _star2Cell.y = 45;
         addChild(_star2Cell);
         _star2Cell.addEventListener("click",moutUpdateHandler);
         _star3Cell = ComponentFactory.Instance.creatCustomObject("theseusgodhead.item.GodheadUpStarCell");
         addChild(_star3Cell);
         _star3Cell.x = 135;
         _star3Cell.y = 220;
         _mItemList = new Vector.<TheseusWarMetrailCell>();
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new TheseusWarMetrailCell();
            _mItemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _star2Btn.enable = false;
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbaglvtxt");
         _costTxt.x = 50;
         _costTxt.y = 110;
         addChild(_costTxt);
         addChild(_currstarContaint);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("EventGodheadInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("EventGodheadInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
         _star2Btn.addEventListener("click",clickHandler);
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
         var _loc23_:GoodsInfo = null;
         var _loc6_:Boolean = false;
         var _loc3_:TheseusWarMetrailCell = null;
         var _loc11_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:Array = null;
         var _loc7_:Object = null;
         var _loc22_:Array = null;
         var _loc21_:TheseusGodheadStoneInfo = null;
         var _loc8_:TheseusSlateInfo = null;
         var _loc19_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:TheseusGodheadStoneInfo = null;
         var _loc5_:Array = null;
         var _loc17_:int = 0;
         var _loc15_:Object = null;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc18_:int = 0;
         var _loc20_:int = 0;
         var _loc24_:TheseusGodheadStoneInfo = TheseussoulManager.Instance.modelGodhead.getStoneById(param1);
         showStar(_loc24_.star,_currstarContaint);
         _nextstarContaint.visible = true;
         _currstarContaint.visible = true;
         _star2NameTxt.text = _loc24_.name;
         _star2Cell.data = _loc24_;
         if(_loc24_.star != _loc24_.maxStar)
         {
            _star2HBox.visible = true;
            _shibanNumTxt.visible = _materCell.visible = _star3Cell.visible = true;
            _star2Btn.visible = true;
            _maxItem.visible = false;
            showStar(_loc24_.star + 1,_nextstarContaint);
            _star2HBox.beginChanges();
            _star2HBox.removeAllChild();
            _loc6_ = true;
            _loc16_ = [];
            _loc7_ = {};
            _loc22_ = _loc24_.getStarUpMaterials(_loc24_.star + 1);
            _loc21_ = _loc24_.clone();
            _loc21_.templateId = _loc22_[0].newStoneid;
            _loc21_.star = _loc24_.star + 1;
            _loc8_ = TheseussoulManager.Instance.modelGodhead.getStoneTemplate(_loc21_.stoneId);
            _star3Cell.data = _loc21_;
            _loc19_ = int(_loc22_[0].itemId);
            _loc9_ = int(_loc22_[0].count);
            _loc4_ = _loc24_.clone();
            _loc5_ = TheseussoulManager.Instance.modelGodhead.getBagStoneCountByTemplateId(_loc19_,_loc24_.stoneId);
            _loc17_ = int(_loc5_.length);
            _loc4_.level = _loc4_.star * 10;
            _materCell.data = _loc4_;
            _shibanNumTxt.text = _loc17_ + "/" + _loc9_;
            _shibanNumTxt.textColor = _loc17_ >= _loc9_ ? 16777215 : 16711680;
            if(_loc22_ && _loc22_.length > 0)
            {
               _loc14_ = 1;
               while(_loc14_ < _loc22_.length)
               {
                  _loc15_ = _loc22_[_loc14_];
                  _loc10_ = int(_loc15_.itemId);
                  _loc12_ = int(_loc15_.count);
                  _loc16_.push(_loc10_);
                  _loc7_[_loc10_] = _loc12_;
                  _loc14_++;
               }
            }
            _loc14_ = 0;
            while(_loc14_ < _loc16_.length)
            {
               _loc20_ = int(_loc7_[_loc18_ = int(_loc16_[_loc14_].toString())]);
               _loc23_ = new GoodsInfo();
               _loc23_.templateId = _loc18_;
               _loc23_.count = _loc20_;
               _loc11_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc18_));
               if(_loc14_ < _mItemList.length)
               {
                  _loc3_ = _mItemList[_loc14_];
                  _loc3_.data = _loc23_;
                  _star2HBox.addChild(_loc3_);
                  _loc6_ &&= _loc11_ >= _loc20_;
               }
               _loc14_++;
            }
            _star2Btn.enable = _loc6_;
            _star2HBox.commitChanges();
            if(isCanUpstar())
            {
               _star2NameTxt.textColor = 7077659;
            }
            else
            {
               _star2NameTxt.textColor = 16711680;
            }
         }
         else
         {
            _nextstarContaint.visible = false;
            _star2HBox.visible = false;
            _shibanNumTxt.visible = _materCell.visible = _star3Cell.visible = false;
            _maxItem.visible = true;
            _star2Btn.visible = false;
            _costTxt.text = "";
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("EventGodheadInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("EventGodheadInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
         _star2Btn.removeEventListener("click",clickHandler);
         _star2Cell.removeEventListener("click",moutUpdateHandler);
      }
      
      private function moutUpdateHandler(param1:MouseEvent) : void
      {
         updateEmpty();
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         updateEmpty();
      }
      
      private function updateEmpty() : void
      {
         _star2Btn.enable = false;
         _star2Cell.data = null;
         _materCell.data = null;
         _star3Cell.data = null;
         _costTxt.text = "";
         _star2HBox.visible = false;
         _nextstarContaint.visible = false;
         _currstarContaint.visible = false;
         _maxItem.visible = false;
         _star2NameTxt.text = "";
         _shibanNumTxt.visible = _materCell.visible = _star3Cell.visible = false;
      }
      
      private function isCanUpstar(param1:Boolean = false) : Boolean
      {
         var _loc15_:TheseusGodheadStoneInfo = null;
         var _loc13_:Array = null;
         var _loc3_:Boolean = false;
         var _loc11_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc14_:GoodsTemplateInfo = null;
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         var _loc10_:int = 0;
         if(_star2Cell.data)
         {
            _loc15_ = _star2Cell.data as TheseusGodheadStoneInfo;
            _loc13_ = _loc15_.getStarUpMaterials(_loc15_.star + 1);
            _loc3_ = true;
            _loc11_ = "";
            if(_loc15_.level < _loc15_.maxLevel)
            {
               if(param1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseusgodhead.txt15",_loc15_.maxLevel));
               }
               return false;
            }
            if(_loc13_ && _loc13_.length > 0)
            {
               _loc8_ = 1;
               while(_loc8_ < _loc13_.length)
               {
                  _loc9_ = _loc13_[_loc8_];
                  _loc4_ = int(_loc9_.itemId);
                  _loc6_ = int(_loc9_.count);
                  _loc7_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc4_));
                  if(_loc7_ < _loc6_)
                  {
                     _loc3_ = false;
                     _loc14_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_);
                     if(_loc14_)
                     {
                        _loc11_ = _loc14_.TemplateName;
                     }
                     break;
                  }
                  _loc8_++;
               }
            }
            _loc12_ = int(_loc13_[0].itemId);
            _loc5_ = int(_loc13_[0].count);
            _loc2_ = TheseussoulManager.Instance.modelGodhead.getBagStoneCountByTemplateId(_loc12_,_loc15_.stoneId);
            _loc10_ = int(_loc2_.length);
            if(_loc10_ < _loc5_)
            {
               _loc3_ = false;
            }
            if(!_loc3_)
            {
               if(param1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseusgodhead.txt16"));
               }
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc7_:TheseusGodheadStoneInfo = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         if(!isCanUpstar(true))
         {
            return;
         }
         if(_star2Cell.data)
         {
            _loc7_ = _star2Cell.data as TheseusGodheadStoneInfo;
            _loc3_ = _loc7_.getStarUpMaterials(_loc7_.star + 1);
            _loc6_ = int(_loc3_[0].itemId);
            _loc4_ = int(_loc3_[0].count);
            _loc2_ = TheseussoulManager.Instance.modelGodhead.getBagStoneCountByTemplateId(_loc6_,_loc7_.stoneId);
            _loc5_ = int((_loc2_[0] as TheseusGodheadStoneInfo).stoneId);
            TheseussoulManager.Instance.starUpSlate(_star2Cell.data.stoneId,_loc5_);
         }
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseusgodhead.message.starupSuccess"));
         dispatchEvent(new Event("close"));
      }
      
      private function starUpSuccessHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TheseusGodheadStoneInfo = null;
         if(_star2Cell.data)
         {
            _loc2_ = int(_star2Cell.data.stoneId);
            _loc3_ = TheseussoulManager.Instance.modelGodhead.getStoneById(_loc2_);
            if(_loc3_)
            {
               updateUI(_loc2_);
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseusgodhead.message.starupSuccess"));
            }
         }
      }
      
      private function _onSlateUpdate(param1:NotificationEvent) : void
      {
         if(param1.data != 4)
         {
            return;
         }
         if(_star2Cell.data && _star2Cell.data.stoneId > 0)
         {
            updateUI(_star2Cell.data.stoneId);
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
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.theseus.warStar3");
               param2.addChild(_loc3_);
            }
            _loc6_++;
         }
         param2.commitChanges();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispatchEvent(new Event("close"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_star2Btn);
         _star2Btn = null;
      }
   }
}

