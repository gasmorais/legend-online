package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.utils.SimpleDictionary;
   
   public class VPropertyBox extends Component
   {
      
      private var _vbox:VBox;
      
      private var _itemList:SimpleDictionary;
      
      private var _vboxStyle:String;
      
      private var _cellStyle:String;
      
      public function VPropertyBox()
      {
         super();
         _itemList = new SimpleDictionary();
      }
      
      public function register(param1:Array) : void
      {
         var _loc2_:FilterFrameText = null;
         var _loc4_:String = null;
         var _loc3_:int = 0;
         _vbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc2_ = ComponentFactory.Instance.creat(_cellStyle);
            _itemList[_loc4_] = _loc2_;
            _vbox.addChild(_loc2_);
            _loc3_++;
         }
         _vbox.commitChanges();
      }
      
      public function attVale(param1:String, param2:String) : void
      {
         _itemList[param1].text = param2;
      }
      
      public function get cellStyle() : String
      {
         return _cellStyle;
      }
      
      public function set cellStyle(param1:String) : void
      {
         _cellStyle = param1;
      }
      
      public function get vboxStyle() : String
      {
         return _vboxStyle;
      }
      
      public function set vboxStyle(param1:String) : void
      {
         if(_vboxStyle == param1)
         {
            return;
         }
         _vboxStyle = param1;
         if(_vbox != null)
         {
            ObjectUtils.disposeObject(_vbox);
            _itemList.clear();
         }
         _vbox = ComponentFactory.Instance.creat(_vboxStyle);
         addChild(_vbox);
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:FilterFrameText in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

