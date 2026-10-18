package cell.view.runebag
{
   import bag.helper.GoodsCheck;
   import cell.mediator.runebag.RuneBagCellClickMediator;
   import cell.mediator.runebag.RuneBagCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class RuneBagCell extends BaseItemView
   {
      
      public static const P_equip:String = "equip";
      
      public static const NAME:String = "cell.view.runebag.RuneBagCell";
      
      private var _equipStyle:String;
      
      protected var _heroEquipIcon:Bitmap;
      
      protected var _shape:Shape;
      
      protected var _registed:Boolean;
      
      protected var _mediatorKey:String;
      
      public function RuneBagCell()
      {
         super();
         createShape();
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equip");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["equip"])
         {
            _heroEquipIcon = ComponentFactory.Instance.creatBitmap(_equipStyle);
            _heroEquipIcon.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_heroEquipIcon)
         {
            addChild(_heroEquipIcon);
         }
      }
      
      private function createShape() : void
      {
         if(!_shape)
         {
            _shape = new Shape();
         }
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawRect(0,0,41,41);
         _shape.graphics.endFill();
         _shape.x = 2;
         _shape.y = 2;
         _shape.blendMode = "multiply";
      }
      
      protected function removeShape() : void
      {
         if(_shape && _shape.parent)
         {
            _shape.parent.removeChild(_shape);
         }
      }
      
      public function checkGoodsByHero(param1:Boolean = true) : Boolean
      {
         if(GoodsCheck.isGradeFix(thane,data.templateInfo,param1))
         {
            return GoodsCheck.checkGoodsByHero(data,thane,param1);
         }
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:int = 0;
         super.data = param1;
         removeShape();
         if(!_registed)
         {
            registerMediator();
         }
         if(_heroEquipIcon)
         {
            _heroEquipIcon.visible = false;
            if(param1)
            {
               _loc2_ = ArmyManager.instance.thane.id;
               if(param1.objectId == _loc2_)
               {
                  _heroEquipIcon.visible = true;
                  _icon.tipStyle = "yishi.view.tips.goods.EquipTip";
               }
            }
         }
         if(!param1)
         {
            return;
         }
         if(GoodsCheck.isEquip(param1.templateInfo) && !checkGoodsByHero(false) && _shape)
         {
            addChild(_shape);
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [RuneBagCellClickMediator,RuneBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.runebag.RuneBagCell");
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
         _heroEquipIcon = null;
      }
      
      override public function get width() : Number
      {
         return 45;
      }
      
      override public function get height() : Number
      {
         return 45;
      }
   }
}

