package monopoly.llk.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.llk.LlkNodeData;
   import yishi.view.tools.SimpleMovie;
   
   public class MonopolyLlkNodeView extends Sprite implements Disposeable
   {
      
      public static var WIDTH:int = 44;
      
      public static var HEIGHT:int = 44;
      
      private var _data:LlkNodeData;
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _deleMc:SimpleMovie;
      
      public function MonopolyLlkNodeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("LlkNodeView.bg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("LlkNodeView.Icon");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_icon);
         _icon.setFrame(1);
         refresh();
      }
      
      public function play() : void
      {
         var _loc1_:MovieClip = null;
         if(_data && _data.mcType > 0)
         {
            trace(_data.col + " " + _data.row + " " + _data.mcType);
            switch(int(_data.mcType) - 1)
            {
               case 0:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteLine");
                  _loc1_.rotation = 90;
                  _loc1_.x = 51;
                  _loc1_.y = 24;
                  break;
               case 1:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteLine");
                  _loc1_.x = 29;
                  _loc1_.y = 2;
                  break;
               case 2:
               case 3:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteMcNode");
                  _loc1_.x = 28;
                  _loc1_.y = 24;
                  break;
               case 4:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteCorner");
                  _loc1_.x = 51;
                  _loc1_.y = 24;
                  break;
               case 5:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteCorner");
                  _loc1_.rotation = 90;
                  _loc1_.x = 29;
                  _loc1_.y = 46;
                  break;
               case 6:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteCorner");
                  _loc1_.rotation = 180;
                  _loc1_.x = 7;
                  _loc1_.y = 24;
                  break;
               case 7:
                  _loc1_ = ComponentFactory.Instance.creat("asset.llk.deleteCorner");
                  _loc1_.rotation = 270;
                  _loc1_.x = 29;
                  _loc1_.y = 2;
            }
            _deleMc = new SimpleMovie(_loc1_);
            _deleMc.mouseChildren = _deleMc.mouseEnabled = false;
            addChild(_deleMc);
            _data.mcType = 0;
         }
      }
      
      private function refresh() : void
      {
         if(_data)
         {
            if(_bg)
            {
               _bg.visible = _data.val > 0;
            }
            if(_icon)
            {
               _icon.visible = _data.val > 0;
            }
            if(_icon)
            {
               _icon.buttonMode = _data.val > 0;
            }
         }
         else
         {
            if(_bg)
            {
               _bg.visible = false;
            }
            if(_icon)
            {
               _icon.visible = false;
            }
         }
      }
      
      public function get data() : LlkNodeData
      {
         return _data;
      }
      
      public function set data(param1:LlkNodeData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         if(_data.val > 0)
         {
            _icon.setFrame(_data.val);
         }
         if(_bg)
         {
            _bg.setFrame(1);
         }
         refresh();
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
      }
      
      public function dispose() : void
      {
         _data = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_deleMc)
         {
            _deleMc.dispose();
         }
         _deleMc = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

