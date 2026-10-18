package map.campaign.view.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tools.SimpleMovie;
   
   public class MapHurtView extends Component
   {
      
      private var _hurt:int;
      
      private var _effectType:int;
      
      private var _container:Component;
      
      private var _numberAsset:BitmapData;
      
      private var _posY:int;
      
      public function MapHurtView(param1:int, param2:int)
      {
         _hurt = param1;
         _effectType = param2;
         super();
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         _container = new Component();
         if(_effectType == 1)
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.vehiclemap.AddNumber");
         }
         else
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.vehiclemap.HurtNumber");
         }
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.vehiclemap.HurtEffect");
         var _loc2_:MovieClip = _loc1_["effectValue"]["number_mc"];
         var _loc5_:MovieClip = _loc1_["effectValue"]["effectType"];
         if(_hurt == -1)
         {
            _loc2_.gotoAndStop(2);
            _loc5_.gotoAndStop(3);
         }
         else if(_hurt == -2)
         {
            _loc2_.gotoAndStop(3);
            _loc5_.gotoAndStop(3);
         }
         else if(_hurt == -3)
         {
            _loc2_.gotoAndStop(4);
            _loc5_.gotoAndStop(3);
         }
         else
         {
            _loc3_ = Math.abs(_hurt);
            NumberViewUtils.getNumberView(_loc3_,_container,_numberAsset,21,21,15,21,"1234567890");
            _loc2_.gotoAndStop(1);
            _loc2_.addChild(_container);
            _loc5_.gotoAndStop(1);
         }
         if(_effectType == 1)
         {
            _loc5_.gotoAndStop(2);
         }
         var _loc4_:SimpleMovie = new SimpleMovie(_loc1_,dispose);
         addChild(_loc4_);
      }
      
      private function uintView() : void
      {
         if(_numberAsset)
         {
            _numberAsset.dispose();
         }
         _numberAsset = null;
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
   }
}

