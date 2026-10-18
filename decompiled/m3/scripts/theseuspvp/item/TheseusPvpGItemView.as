package theseuspvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import yishi.view.community.BaseItemView;
   
   public class TheseusPvpGItemView extends BaseItemView
   {
      
      public static const P_GouStyle:String = "gouStyle";
      
      public static const P_LockStyle:String = "lockStyle";
      
      private var _gouStyle:String;
      
      private var _gou:Image;
      
      private var _lockStyle:String;
      
      private var _lockFlg:Image;
      
      public function TheseusPvpGItemView()
      {
         super();
      }
      
      public function get gouStyle() : String
      {
         return _gouStyle;
      }
      
      public function set gouStyle(param1:String) : void
      {
         _gouStyle = param1;
         onPropertiesChanged("gouStyle");
      }
      
      public function get lockStyle() : String
      {
         return _lockStyle;
      }
      
      public function set lockStyle(param1:String) : void
      {
         _lockStyle = param1;
         onPropertiesChanged("lockStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["gouStyle"])
         {
            _gou = ComponentFactory.Instance.creat(_gouStyle);
         }
         if(_changedPropeties["lockStyle"])
         {
            _lockFlg = ComponentFactory.Instance.creat(_lockStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_gou)
         {
            addChild(_gou);
         }
         if(_lockFlg)
         {
            addChild(_lockFlg);
         }
      }
      
      public function gouState(param1:Boolean) : void
      {
         if(_gou)
         {
            _gou.visible = param1;
         }
      }
      
      public function lockState(param1:Boolean) : void
      {
         if(_lockFlg)
         {
            _lockFlg.visible = param1;
         }
      }
   }
}

