package maze.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import map.internals.data.template.MapTemplate;
   import yishi.manager.TempleteManager;
   
   public class MazeFloorItem extends Component
   {
      
      public var index:int;
      
      private var _icon:ScaleFrameImage;
      
      private var _text:Bitmap;
      
      private var _type:int;
      
      public function MazeFloorItem(param1:int, param2:int)
      {
         super();
         index = param1;
         _type = param2;
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("maze.FloorIconTxt");
         _text = ComponentFactory.Instance.creatBitmap("asset.maze.Floor_" + index);
         addChild(_icon);
         addChild(_text);
         _icon.setFrame(_type);
         tipData = fallsArr;
      }
      
      private function get fallsArr() : Array
      {
         var _loc2_:int = 0;
         if(_type == 1)
         {
            _loc2_ = int(index == 100 ? 8100 : int("80" + index));
         }
         else
         {
            _loc2_ = int(index == 5 ? 8105 : int("81" + index));
         }
         var _loc1_:Array = [];
         var _loc3_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc2_);
         if(_loc3_)
         {
            _loc1_ = _loc3_.Description.split(",");
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _text = null;
         super.dispose();
      }
   }
}

