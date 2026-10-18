package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.monster.MonsterInfo;
   
   public class MonsterPropSeeViewFrame extends Frame
   {
      
      private var _infoView:MonsterPropView;
      
      public function MonsterPropSeeViewFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _infoView = ComponentFactory.Instance.creatCustomObject("playerInfo.MonsterFrame.propView",[false]);
         addToContent(_infoView);
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         _infoView.changeOtherData(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         super.dispose();
      }
   }
}

