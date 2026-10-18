package
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mainBar.ChatBar;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.manager.PlayerManager;
   
   public class §CubXcb{qDD[o{Kn§ extends Frame
   {
      
      private var _bg:Bitmap;
      
      public function §CubXcb{qDD[o{Kn§()
      {
         super();
      }
      
      protected function setBg(param1:String) : void
      {
         _bg = ComponentFactory.Instance.creatBitmap(param1);
         addToContent(_bg);
      }
      
      protected function setUIVisible(param1:String = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         MainToolBar.instance.hide();
         ChatBar.instance.hide();
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            MainToolBar.instance.poptipButtonVisible = false;
         }
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         TimeBoxView.instance.hide();
         TopToolsBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
         if(param1 && param1 != "")
         {
            _loc2_ = param1.split("_");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               switch(_loc2_[_loc3_])
               {
                  case "1":
                     MainToolBar.instance.show();
                     break;
                  case "2":
                     ChatBar.instance.show();
                     break;
                  case "3":
                     if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
                     {
                        MainToolBar.instance.poptipButtonVisible = true;
                     }
                     break;
                  case "4":
                     TaskTraceBar.instance.show();
                     break;
                  case "5":
                     QueueBar.instance.show();
                     break;
                  case "6":
                     TimeBoxView.instance.show();
                     break;
                  case "7":
                     TopToolsBar.instance.show();
                     break;
                  case "8":
                     ResourcesBar.instance.show();
                     break;
                  case "9":
                     SmallMapBar.instance.show();
               }
               _loc3_++;
            }
            return;
         }
      }
      
      public function get bg() : Bitmap
      {
         return _bg;
      }
      
      override public function get height() : Number
      {
         if(_bg)
         {
            return _bg.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return super.width;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

