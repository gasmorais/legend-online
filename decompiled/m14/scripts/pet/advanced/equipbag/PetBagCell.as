package pet.advanced.equipbag
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class PetBagCell extends BaseItemView
   {
      
      public static const P_equipImg:String = "equipStyle";
      
      public static const NAME:String = "pet.advanced.equipbag.PetEquipBagCell";
      
      private var _equipStyle:String;
      
      protected var _petEquipIcon:Bitmap;
      
      private var _shape:Shape;
      
      protected var _registed:Boolean;
      
      protected var _mediatorKey:String;
      
      public function PetBagCell()
      {
         super();
         createShape();
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
      
      private function removeShape() : void
      {
         if(_shape && _shape.parent)
         {
            _shape.parent.removeChild(_shape);
         }
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equipStyle");
      }
      
      public function get equipStyle() : String
      {
         return _equipStyle;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["equipStyle"])
         {
            _petEquipIcon = ComponentFactory.Instance.creatBitmap(_equipStyle);
            _petEquipIcon.visible = false;
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(_petEquipIcon)
         {
            if(param1 && param1.objectId > 0)
            {
               _petEquipIcon.visible = true;
            }
            else
            {
               _petEquipIcon.visible = false;
            }
         }
         if(param1 && param1.templateInfo.MasterType == 5 && param1.mouldGrade >= param1.templateInfo.StrengthenMax)
         {
            if(_strengthenIcon)
            {
               _strengthenIcon.visible = true;
            }
         }
         else if(_strengthenIcon)
         {
            _strengthenIcon.visible = false;
         }
         removeShape();
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_petEquipIcon)
         {
            addChild(_petEquipIcon);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [PetBagCellClickMediator,PetBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"pet.advanced.equipbag.PetEquipBagCell");
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
         _petEquipIcon = null;
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

