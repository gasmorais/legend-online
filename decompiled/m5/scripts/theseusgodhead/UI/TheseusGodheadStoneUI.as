package theseusgodhead.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusSlateAssetHelper;
   import theseusgodhead.mediator.TheseussoulEquipCellDropMediator;
   import yishi.events.NotificationEvent;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   
   public class TheseusGodheadStoneUI extends Sprite
   {
      
      private var _stoneInfo:TheseusGodheadStoneInfo;
      
      private var _slateBitmap:Bitmap;
      
      private var _shape:int;
      
      private var _rotate:int;
      
      private var _star:int;
      
      private var _starContainer:Sprite;
      
      private var _tipComponent:TransformableComponent;
      
      private var _isRigist:Boolean;
      
      private var tetrominoes:Array;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseusgodhead.UI.TheseusGodheadStoneUI";
      
      public function TheseusGodheadStoneUI()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STONEUI_MOUSENABLECHANGE",changeContainer);
      }
      
      public function changeContainer(param1:NotificationEvent) : void
      {
         if(_tipComponent)
         {
            _tipComponent.mouseEnabled = param1.data;
         }
      }
      
      private function initView() : void
      {
         this.mouseEnabled = true;
         _tipComponent = new TransformableComponent();
         _tipComponent.x = 0;
         _tipComponent.y = 0;
         _tipComponent.tipStyle = "yishi.view.tips.TheseusGodheadEquipTip";
         _tipComponent.isFollowMouse = true;
         _tipComponent.mouseEnabled = true;
         addChild(_tipComponent);
         tetrominoes = [[[1,1,1],[0,1,0],[0,0,0]],[[1,0,0],[1,1,0],[1,0,0]],[[0,1,0],[1,1,1],[0,0,0]],[[0,1,0],[1,1,0],[0,1,0]],[[0,1,1],[1,1,0],[0,0,0]],[[1,0,0],[1,1,0],[0,1,0]],[[0,1,0],[0,1,0],[1,1,0]],[[1,0,0],[1,1,1],[0,0,0]],[[1,1,0],[1,0,0],[1,0,0]],[[1,1,1],[0,0,1],[0,0,0]],[[1,1,0],[0,1,0],[0,0,0]],[[0,1,0],[1,1,0],[0,0,0]],[[1,0,0],[1,1,0],[0,0,0]],[[1,1,0],[1,0,0],[0,0,0]]];
      }
      
      public function stoneInfo() : TheseusGodheadStoneInfo
      {
         return _stoneInfo;
      }
      
      public function setStoneData(param1:TheseusGodheadStoneInfo, param2:int) : void
      {
         _stoneInfo = param1;
         if(!param1 || !param1.isExist)
         {
            clearDisplay();
            return;
         }
         _shape = param1.shape > 0 ? param1.shape : 1;
         _rotate = param1.rotate || 0;
         _star = param1.star || 0;
         clearDisplay();
         _slateBitmap = TheseusSlateAssetHelper.getSlateDisplay(_shape,_rotate);
         if(_slateBitmap)
         {
            addChild(_slateBitmap);
            if(_tipComponent)
            {
               _tipComponent.tipData = param1;
               _tipComponent.graphics.beginFill(0,0);
               _tipComponent.graphics.drawRect(0,0,_slateBitmap.width,_slateBitmap.height);
               _tipComponent.graphics.endFill();
               this.addChild(_tipComponent);
            }
            confirmHitAreaByshape(_shape,_rotate);
         }
         showStars();
         if(!_isRigist)
         {
            registerMediator();
         }
      }
      
      private function showStars() : void
      {
         if(_star <= 0)
         {
            return;
         }
         _starContainer = new Sprite();
         addChild(_starContainer);
         var _loc1_:int = getDirectByshape(_shape,_rotate);
         drawStar(_loc1_,_star);
      }
      
      public function getDirectByshape(param1:int, param2:int) : int
      {
         var _loc3_:int = 1;
         switch(param1 - 1)
         {
            case 0:
               if(param2 == 0)
               {
                  return 1;
               }
               if(param2 == 1)
               {
                  return 3;
               }
               if(param2 == 2)
               {
                  return 2;
               }
               return 4;
               break;
            case 1:
               if(param2 == 3 || param2 == 1)
               {
                  return 6;
               }
               return 7;
               break;
            case 2:
               if(param2 == 0)
               {
                  return 3;
               }
               if(param2 == 1)
               {
                  return 2;
               }
               if(param2 == 2)
               {
                  return 4;
               }
               return 1;
               break;
            case 3:
               if(param2 == 0)
               {
                  return 1;
               }
               if(param2 == 1)
               {
                  return 3;
               }
               if(param2 == 2)
               {
                  return 4;
               }
               return 1;
               break;
            case 4:
               if(param2 == 0 || param2 == 2)
               {
                  return 4;
               }
               if(param2 == 1)
               {
                  return 1;
               }
               break;
            case 5:
               if(param2 == 0 || param2 == 2)
               {
                  return 1;
               }
               if(param2 == 1)
               {
                  return 4;
               }
               break;
            case 6:
               return 5;
         }
         return _loc3_;
      }
      
      public function drawStar(param1:int, param2:int = 0) : void
      {
         var _loc7_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc3_:int = 15;
         var _loc8_:int = (param2 - 1) * _loc3_;
         var _loc10_:int = _slateBitmap ? _slateBitmap.height : 0;
         var _loc5_:int = _slateBitmap ? _slateBitmap.width : 0;
         var _loc9_:int = (_loc10_ - _loc8_) / 2;
         var _loc6_:int = (_loc5_ - _loc8_) / 2;
         var _loc12_:int = (_loc5_ / 3 * 2 - _loc8_) / 2;
         var _loc11_:int = (_loc10_ / 3 * 2 - _loc8_) / 2;
         _loc7_ = 0;
         while(_loc7_ < param2)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.theseus.warStar3");
            if(_loc4_)
            {
               if(param1 == 1)
               {
                  _loc4_.x = _loc7_ * _loc3_ + _loc6_ - 5;
                  _loc4_.y = _loc10_ / 4 - 8;
                  if(_shape == 6)
                  {
                     _loc4_.y = _loc10_ / 4 + 5;
                  }
               }
               else if(param1 == 2)
               {
                  _loc4_.x = _loc7_ * _loc3_ + _loc6_;
                  _loc4_.y = _loc10_ / 2 + 20;
               }
               else if(param1 == 3)
               {
                  _loc4_.x = _loc5_ / 2 + 20;
                  _loc4_.y = _loc7_ * _loc3_ + _loc9_ - 10;
               }
               else if(param1 == 4)
               {
                  _loc4_.x = _loc5_ / 4 - 8;
                  _loc4_.y = _loc7_ * _loc3_ + _loc9_;
               }
               else if(param1 == 5)
               {
                  _loc4_.x = (_loc7_ + 1) * _loc3_;
                  _loc4_.y = _loc10_ / 4;
                  if(_loc7_ >= 2)
                  {
                     _loc4_.x = (_loc7_ - 2) * _loc3_ + 5;
                     _loc4_.y = _loc10_ / 2;
                  }
               }
               else if(param1 == 6)
               {
                  _loc4_.x = _loc7_ * _loc3_ + _loc12_ + _loc5_ / 3;
                  _loc4_.y = _loc10_ / 4 - 10;
               }
               else
               {
                  _loc4_.x = _loc5_ / 4 - 8;
                  _loc4_.y = _loc7_ * _loc3_ + _loc11_;
               }
               _starContainer.addChild(_loc4_);
            }
            _loc7_++;
         }
      }
      
      private function clearDisplay() : void
      {
         if(_slateBitmap && _slateBitmap.parent)
         {
            removeChild(_slateBitmap);
            _slateBitmap = null;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function updateStar(param1:int) : void
      {
         _star = param1;
         showStars();
      }
      
      public function dispose() : void
      {
         clearDisplay();
         NotificationManager.instance.removeEventListener("STONEUI_MOUSENABLECHANGE",changeContainer);
         unregisterMediator();
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_tipComponent);
         _tipComponent = null;
         ObjectUtils.disposeObject(_slateBitmap);
         _slateBitmap = null;
      }
      
      protected function registerMediator() : void
      {
         _isRigist = true;
         var _loc1_:Array = [TheseussoulEquipCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseusgodhead.UI.TheseusGodheadStoneUI");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function confirmHitAreaByshape(param1:int, param2:int) : void
      {
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc4_:* = 0;
         var _loc7_:* = 0;
         var _loc5_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               if(param2 == 0)
               {
                  _loc5_ = 0;
               }
               if(param2 == 1)
               {
                  _loc5_ = 3;
               }
               if(param2 == 2)
               {
                  _loc5_ = 2;
               }
               if(param2 == 3)
               {
                  _loc5_ = 1;
               }
               break;
            case 1:
               if(param2 == 0 || param2 == 2)
               {
                  _loc5_ = 5;
               }
               if(param2 == 1 || param2 == 3)
               {
                  _loc5_ = 4;
               }
               break;
            case 2:
               if(param2 == 0)
               {
                  _loc5_ = 6;
               }
               if(param2 == 1)
               {
                  _loc5_ = 7;
               }
               if(param2 == 2)
               {
                  _loc5_ = 8;
               }
               if(param2 == 3)
               {
                  _loc5_ = 9;
               }
               break;
            case 3:
               if(param2 == 0)
               {
                  _loc5_ = 10;
               }
               if(param2 == 1)
               {
                  _loc5_ = 11;
               }
               if(param2 == 2)
               {
                  _loc5_ = 12;
               }
               if(param2 == 3)
               {
                  _loc5_ = 13;
               }
               break;
            default:
               return;
         }
         if(_tipComponent)
         {
            _tipComponent.graphics && _tipComponent.graphics.clear();
         }
         var _loc3_:Sprite = new Sprite();
         var _loc9_:Array = tetrominoes[_loc5_];
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               if(_loc9_[_loc6_][_loc8_] == 1)
               {
                  _loc4_ = uint(_loc8_ * 60);
                  _loc7_ = uint(_loc6_ * 60);
                  _loc3_.graphics.beginFill(0);
                  _loc3_.graphics.drawRect(_loc4_,_loc7_,60,60);
                  _loc3_.graphics.endFill();
                  if(_tipComponent)
                  {
                     _tipComponent.graphics.beginFill(0,0);
                     _tipComponent.graphics.drawRect(_loc4_,_loc7_,60,60);
                     _tipComponent.graphics.endFill();
                  }
               }
               _loc8_++;
            }
            _loc6_++;
         }
         this.hitArea = _loc3_;
         this.hitTestObject(_loc3_);
      }
   }
}

