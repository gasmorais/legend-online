package goddess
{
   import avatar.load.ShowAvatarLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import goddess.view.GoddessEquipView;
   import mvc.module.goddess.GoddessInfo;
   import yishi.manager.PathManager;
   
   public class GodDessEquipLookInfoFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _avater:ShowAvatarLoader;
      
      private var _equipView:GoddessEquipView;
      
      private var _data:GoddessInfo;
      
      public function GodDessEquipLookInfoFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.goddess.roleBg");
         _avater = new ShowAvatarLoader(null);
         _equipView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessEquipView");
         addToContent(_bg);
         _bg.x = 10;
         _bg.y = 0;
         addToContent(_avater);
         _avater.x = 10;
         _avater.y = 0;
         addToContent(_equipView);
         _equipView.x = 28;
         _equipView.y = 15;
         _avater.mouseChildren = _avater.mouseEnabled = false;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:String = PathManager.getGoddessAvaterPath(_data.tempInfo.Resource);
         _avater.initPath(_loc2_);
         _equipView.data = _data;
         _equipView.selectIndex = 1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_avater);
         _avater = null;
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         super.dispose();
      }
   }
}

