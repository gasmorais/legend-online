package theseus.war.item
{
   import flash.display.Shape;
   import theseus.war.mediator.TheseusMetrialBagCellClickMediator;
   import theseus.war.mediator.TheseusMetrialBagCellDropMediator;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class TheseusMetrialBagCell extends BaseItemView
   {
      
      public static const NAME:String = "theseus.war.item.TheseusMetrialBagCell";
      
      protected var _shape:Shape;
      
      protected var _registed:Boolean;
      
      protected var _mediatorKey:String;
      
      public function TheseusMetrialBagCell()
      {
         super();
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
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         removeShape();
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [TheseusMetrialBagCellClickMediator,TheseusMetrialBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusMetrialBagCell");
      }
      
      override public function get width() : Number
      {
         return 45;
      }
      
      override public function get height() : Number
      {
         return 45;
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
   }
}

