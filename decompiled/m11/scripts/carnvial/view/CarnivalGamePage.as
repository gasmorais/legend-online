package carnvial.view
{
   import carnvial.item.CarnivalGameItem;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.TempleteManager;
   
   public class CarnivalGamePage extends BaseCarnivalPage
   {
      
      private var _itemCanvas:Sprite;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _gameItems:Array;
      
      private var _centerGameItemIndex:int = 1;
      
      public function CarnivalGamePage()
      {
         super();
         initEvent();
      }
      
      override protected function initView() : void
      {
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.game.LeftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.game.RightBtn");
         initItem();
         addChild(_leftBtn);
         addChild(_rightBtn);
      }
      
      private function initItem() : void
      {
         var _loc1_:CarnivalPlayGroundTemplateInfo = null;
         var _loc3_:CarnivalGameItem = null;
         var _loc2_:int = 0;
         _gameItems = [];
         _itemCanvas = new Sprite();
         _itemCanvas.x = 20;
         _itemCanvas.y = 26;
         _itemCanvas.scrollRect = new Rectangle(0,0,755,487);
         addChild(_itemCanvas);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = TempleteManager.instance.carnivalPlayGroundTemplateCate.getTempByType(_loc2_ + 1);
            _loc3_ = new CarnivalGameItem();
            _loc3_.tempInfo = _loc1_;
            _loc3_.refreshView(model.gameInfo);
            _itemCanvas.addChild(_loc3_);
            _loc3_.x = 5 + _loc2_ * 200;
            _loc3_.y = 30;
            _loc3_.scaleX = _loc3_.scaleY = 0.9;
            _loc3_.alpha = 0.5;
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
            _gameItems.push(_loc3_);
            _loc2_++;
         }
         moveGameItem(0);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _leftBtn.addEventListener("click",onLeftBtnClick);
         _rightBtn.addEventListener("click",onRightBtnClick);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _leftBtn.removeEventListener("click",onLeftBtnClick);
         _rightBtn.removeEventListener("click",onRightBtnClick);
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:String = model.gameInfo;
         for each(var _loc2_:CarnivalGameItem in _gameItems)
         {
            _loc2_.refreshView(_loc3_);
         }
      }
      
      private function onLeftBtnClick(param1:MouseEvent) : void
      {
         moveGameItem(-1);
      }
      
      private function onRightBtnClick(param1:MouseEvent) : void
      {
         moveGameItem(1);
      }
      
      private function moveGameItem(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 1;
         _loc5_ = 0;
         while(_loc5_ < Math.abs(param1))
         {
            if(param1 < 0)
            {
               _loc2_ = -1;
            }
            _centerGameItemIndex += _loc2_;
            if(_centerGameItemIndex < 0)
            {
               _centerGameItemIndex = _centerGameItemIndex = _gameItems.length - 1;
            }
            if(_centerGameItemIndex > _gameItems.length - 1)
            {
               _centerGameItemIndex = 0;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _gameItems.length)
         {
            if(_loc5_ - _centerGameItemIndex <= -2)
            {
               _gameItems[_loc5_].x = -260;
               _gameItems[_loc5_].y = 30;
               _gameItems[_loc5_].scaleX = _gameItems[_loc5_].scaleY = 0.9;
               _gameItems[_loc5_].alpha = 0.5;
               _gameItems[_loc5_].mouseEnabled = _gameItems[_loc5_].mouseChildren = false;
            }
            else if(_loc5_ - _centerGameItemIndex >= 2)
            {
               _gameItems[_loc5_].x = 760;
               _gameItems[_loc5_].y = 30;
               _gameItems[_loc5_].scaleX = _gameItems[_loc5_].scaleY = 0.9;
               _gameItems[_loc5_].alpha = 0.5;
               _gameItems[_loc5_].mouseEnabled = _gameItems[_loc5_].mouseChildren = false;
            }
            _loc5_++;
         }
         _gameItems[_centerGameItemIndex].mouseEnabled = _gameItems[_centerGameItemIndex].mouseChildren = true;
         TweenMax.to(_gameItems[_centerGameItemIndex],0.3,{
            "x":232,
            "y":5,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         var _loc3_:int = _centerGameItemIndex - 1 < 0 ? _gameItems.length - 1 : _centerGameItemIndex - 1;
         _gameItems[_loc3_].mouseEnabled = _gameItems[_loc3_].mouseChildren = false;
         TweenMax.to(_gameItems[_loc3_],0.1,{
            "x":5,
            "y":30,
            "scaleX":0.9,
            "scaleY":0.9,
            "alpha":0.5
         });
         var _loc4_:int = _centerGameItemIndex + 1 > _gameItems.length - 1 ? 0 : _centerGameItemIndex + 1;
         _gameItems[_loc4_].mouseEnabled = _gameItems[_loc4_].mouseChildren = false;
         TweenMax.to(_gameItems[_loc4_],0.1,{
            "x":495,
            "y":30,
            "scaleX":0.9,
            "scaleY":0.9,
            "alpha":0.5
         });
         _itemCanvas.setChildIndex(_gameItems[_centerGameItemIndex],_itemCanvas.numChildren - 1);
      }
      
      override protected function clearView() : void
      {
         for each(var _loc1_:DisplayObject in _gameItems)
         {
            TweenMax.killTweensOf(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         _gameItems = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
      }
   }
}

