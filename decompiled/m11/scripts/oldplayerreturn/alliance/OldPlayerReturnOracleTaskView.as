package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnOracleTaskView extends Component
   {
      
      private var _spanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      public function OldPlayerReturnOracleTaskView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _spanel = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskView.bossSpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnOracleTaskView.vBox");
         addChild(_spanel);
         _spanel.setView(_vBox);
      }
      
      public function refreshView() : void
      {
         var _loc1_:OldPlayerReturnOracleTaskItem = null;
         var _loc3_:int = 0;
         _vBox.beginChanges();
         var _loc2_:int = int(model.oracleList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_itemList[_loc3_])
            {
               _loc1_ = _itemList[_loc3_];
               _loc1_.data = model.oracleList[_loc3_];
            }
            else
            {
               _loc1_ = new OldPlayerReturnOracleTaskItem();
               _loc1_.data = model.oracleList[_loc3_];
               _vBox.addChild(_loc1_);
               _itemList.push(_loc1_);
            }
            _loc3_++;
         }
         _vBox.commitChanges();
         _spanel.invalidateViewport();
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:OldPlayerReturnOracleTaskItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

