package christmas.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.christmas.ChristmasModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ChristmasManager;
   import yishi.view.community.BaseItemView;
   
   public class ChristmascjSonItem1 extends Sprite
   {
      
      protected var _itemBg:Bitmap;
      
      protected var _chose:Bitmap;
      
      protected var _cjsonNum1:FilterFrameText;
      
      private var _tempInfo:ChristmasActivitiesTempInfo;
      
      private var _itemList:Array = [];
      
      private var _itemContainer:SimpleTileList;
      
      private var _receivedBg:Bitmap;
      
      private var _effList:Array = [];
      
      private var _effContainer:SimpleTileList;
      
      public function ChristmascjSonItem1()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.itemBg");
         _chose = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.chose");
         _cjsonNum1 = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjsonNum1");
         _itemContainer = ComponentFactory.Instance.creatCustomObject("ui.Christmas.cjSimpleTlist",[2]);
         _receivedBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerPreviewItem.bmp");
         _effContainer = ComponentFactory.Instance.creatCustomObject("ui.Christmas.cjEffSimpleTlist",[2]);
         addChild(_itemBg);
         addChild(_chose);
         addChild(_cjsonNum1);
         addChild(_itemContainer);
         addChild(_receivedBg);
         addChild(_effContainer);
         _receivedBg.x = 30;
         _receivedBg.y = 100;
         _receivedBg.visible = false;
      }
      
      public function set tempInfo(param1:ChristmasActivitiesTempInfo) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc3_:MovieImage = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         _tempInfo = param1;
         if(!_tempInfo)
         {
            return;
         }
         _itemContainer.beginChanges();
         _loc6_ = 1;
         while(_loc6_ <= 4)
         {
            _loc7_ = int(_tempInfo["Reward" + _loc6_]);
            if(_loc7_ > 0)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.EquipActiveBack");
               _loc3_.width = 63;
               _loc3_.height = 62;
               _loc3_.movie.gotoAndStop(1);
               _loc3_.visible = false;
               _effList.push(_loc3_);
               _effContainer.addChild(_loc3_);
               _loc5_ = new GoodsInfo();
               _loc4_ = int(_tempInfo["Num" + _loc6_]);
               _loc5_.showCount = true;
               _loc5_.templateId = _loc7_;
               _loc5_.count = _loc4_;
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc2_.data = _loc5_;
               _itemList.push(_loc2_);
               _itemContainer.addChild(_loc2_);
            }
            _loc6_++;
         }
         _itemContainer.commitChanges();
         _cjsonNum1.text = _tempInfo.Para1.toString();
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc3_:MovieImage = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_itemList.length);
         if(model.scoreRewardInfoList && model.scoreRewardInfoList.indexOf("" + _tempInfo.Id) != -1)
         {
            _receivedBg.visible = true;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = _itemList[_loc4_];
               _loc1_.filters = [UIFilter.getGrayFilter()];
               _loc3_ = _effList[_loc4_];
               _loc3_.movie.gotoAndStop(1);
               _loc3_.visible = false;
               _loc4_++;
            }
            _chose.visible = false;
            removeEvent();
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = _itemList[_loc4_];
               _loc1_.filters = [];
               _loc3_ = _effList[_loc4_];
               if(model.score >= _tempInfo.Para1)
               {
                  _loc3_.movie.gotoAndPlay(1);
                  _loc3_.visible = true;
               }
               else
               {
                  _loc3_.visible = false;
                  _loc3_.movie.gotoAndStop(1);
               }
               _loc4_++;
            }
            if(model.score >= _tempInfo.Para1)
            {
               _chose.visible = true;
               removeEvent();
               addEvent();
            }
            else
            {
               _chose.visible = false;
               removeEvent();
            }
         }
      }
      
      private function addEvent() : void
      {
         this.buttonMode = true;
         this.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.buttonMode = false;
         this.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(14,_tempInfo.Id);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_effList);
         _effList = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_chose);
         _chose = null;
         ObjectUtils.disposeObject(_cjsonNum1);
         _cjsonNum1 = null;
         ObjectUtils.disposeObject(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeObject(_effContainer);
         _effContainer = null;
         ObjectUtils.disposeObject(_receivedBg);
         _receivedBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _tempInfo = null;
      }
   }
}

