package com.map.vehicle.action
{
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleNpcAvatarView;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tools.SimpleMovie;
   
   public class HurtNumberAction extends BaseVehicleAction
   {
      
      private var _hurtData:HurtData;
      
      private var _target:BitmapSimpleLogic;
      
      private var _container:Sprite = new Sprite();
      
      private var _numberAsset:BitmapData;
      
      private var _posY:int;
      
      public function HurtNumberAction(param1:BitmapSimpleLogic, param2:HurtData, param3:int = -120)
      {
         _target = param1;
         _hurtData = param2;
         _posY = param3;
         if(_hurtData.effectType == 1)
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.vehiclemap.AddNumber");
         }
         else
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.vehiclemap.HurtNumber");
         }
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function prepare() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.vehiclemap.HurtEffect");
         var _loc2_:MovieClip = _loc1_["effectValue"]["number_mc"];
         var _loc5_:MovieClip = _loc1_["effectValue"]["effectType"];
         if(_hurtData.effectValue == -1)
         {
            _loc2_.gotoAndStop(2);
            _loc5_.gotoAndStop(3);
         }
         else if(_hurtData.effectValue == -2)
         {
            _loc2_.gotoAndStop(3);
            _loc5_.gotoAndStop(3);
         }
         else if(_hurtData.effectValue == -3)
         {
            _loc2_.gotoAndStop(4);
            _loc5_.gotoAndStop(3);
         }
         else
         {
            _loc3_ = Math.abs(_hurtData.effectValue);
            NumberViewUtils.getNumberView(_loc3_,_container,_numberAsset,21,21,15,21,"1234567890");
            _loc2_.addChild(_container);
            _loc2_.gotoAndStop(1);
            _loc5_.gotoAndStop(1);
         }
         if(_hurtData.effectType == 1)
         {
            _loc5_.gotoAndStop(2);
         }
         var _loc4_:SimpleMovie = new SimpleMovie(_loc1_);
         _loc4_.y = _posY;
         if(_target is TankAvatarView)
         {
            (_target as TankAvatarView).addHurtMovie(_loc4_);
         }
         else if(_target is VehicleNpcAvatarView)
         {
            (_target as VehicleNpcAvatarView).addHurtMovie(_loc4_);
         }
         _finished = true;
         _numberAsset.dispose();
         _numberAsset = null;
      }
      
      override public function update() : void
      {
      }
   }
}

