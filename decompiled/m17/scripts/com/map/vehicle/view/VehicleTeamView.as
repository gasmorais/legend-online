package com.map.vehicle.view
{
   import com.greensock.TweenMax;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class VehicleTeamView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _flag:ScaleFrameImage;
      
      private var _hideBtn:BaseButton;
      
      private var _isHide:Boolean;
      
      private var _itemList:Array;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _rect:Shape;
      
      private var _sprite:Sprite;
      
      private var _teamTxt:Bitmap;
      
      private var _tween:TweenMax;
      
      public function VehicleTeamView()
      {
         super();
         initView();
         addEvent();
         update();
      }
      
      override public function dispose() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
         removeEvent();
         uintView();
         super.dispose();
         _model = null;
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = 0;
         this.y = 300;
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
      }
      
      private function __addPlayerHandler(param1:VehicleEvent) : void
      {
         if(_model.selfVehicleInfo)
         {
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            if(_flag)
            {
               _flag.setFrame(_model.selfVehicleInfo.team);
            }
         }
      }
      
      private function __hideClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
         if(_isHide)
         {
            _isHide = false;
            _hideBtn.scaleX = -1;
            _hideBtn.x = 6 + _hideBtn.displayWidth;
            _tween = TweenMax.to(_rect,0.3,{
               "height":203,
               "width":87,
               "onUpdate":onTween,
               "onComplete":onCompleteHander
            });
            _sprite.y = 32;
         }
         else
         {
            _isHide = true;
            _hideBtn.scaleX = 1;
            _hideBtn.x = 6;
            _tween = TweenMax.to(_rect,0.3,{
               "height":0,
               "width":0,
               "onUpdate":onTween
            });
         }
      }
      
      private function onTween() : void
      {
         _sprite.mask = _rect;
      }
      
      private function onCompleteHander() : void
      {
         _sprite.mask = null;
      }
      
      private function __removePlayerHandler(param1:VehicleEvent) : void
      {
         for each(var _loc2_:VehicleTeamItemView in _itemList)
         {
            if(_loc2_.data == param1.data)
            {
               _loc2_.data = null;
            }
         }
         update();
      }
      
      private function __updateListHandler(param1:VehicleEvent) : void
      {
         update();
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("PLAYE_LIST_UPDATE",__updateListHandler);
         _model.addEventListener("remove_player",__removePlayerHandler);
         _hideBtn.addEventListener("click",__hideClickHandler);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:VehicleTeamItemView = null;
         _back = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamBack");
         _teamTxt = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamText");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.HideBtn");
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.x = 78;
         _flag.y = 2;
         _sprite = new Sprite();
         _sprite.x = 4;
         _sprite.y = 32;
         addChild(_back);
         addChild(_teamTxt);
         addChild(_hideBtn);
         addChild(_flag);
         addChild(_sprite);
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new VehicleTeamItemView();
            _sprite.addChild(_loc1_);
            _loc1_.y = _loc2_ * 67;
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _rect = new Shape();
         _rect.graphics.beginFill(0,0);
         _rect.graphics.drawRect(0,0,87,203);
         _rect.graphics.endFill();
         _rect.x = 4;
         _rect.y = 32;
         addChild(_rect);
         _hideBtn.scaleX = -1;
         _hideBtn.x = 6 + _hideBtn.displayWidth;
         if(_model.selfVehicleInfo)
         {
            _flag.setFrame(_model.selfVehicleInfo.team);
         }
         else
         {
            _model.addEventListener("addPlayer",__addPlayerHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("PLAYE_LIST_UPDATE",__updateListHandler);
            _model.removeEventListener("remove_player",__removePlayerHandler);
            _model.removeEventListener("addPlayer",__addPlayerHandler);
         }
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__hideClickHandler);
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeAllChildren(_sprite);
         _sprite = null;
         _itemList = null;
         _teamTxt = null;
         _back = null;
      }
      
      private function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:VehicleTeamItemView = null;
         var _loc1_:Array = _model.getTeamMembers();
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc3_++;
         }
      }
   }
}

