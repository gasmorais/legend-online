package childnswar.view
{
   import childnswar.item.ChildNswarChooseItemUI;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   
   public class ChildNswarChooseView extends Frame
   {
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<ChildNswarChooseItemUI> = new Vector.<ChildNswarChooseItemUI>();
      
      public function ChildNswarChooseView()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritListView.itemVbox");
         addToContent(_vbox);
         titleText = LanguageMgr.GetTranslation("childnswar.team.chooseTitle");
      }
      
      private function initData() : void
      {
         var _loc2_:ChildNswarChooseItemUI = null;
         var _loc4_:int = 0;
         var _loc1_:Array = nsModel.nsList;
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ChildNswarChooseItemUI();
            _loc2_.childData = _loc1_[_loc4_];
            _itemList[_loc4_] = _loc2_;
            _vbox.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      public function updatePosView(param1:String) : void
      {
         var _loc3_:ChildNswarChooseItemUI = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = param1.split(",");
         var _loc4_:int = int(_itemList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _itemList[_loc5_];
            if(_loc3_.childData)
            {
               _loc7_ = -1;
               _loc6_ = 0;
               while(_loc6_ < 5)
               {
                  if(_loc3_.childData.childId == int(_loc2_[_loc6_]))
                  {
                     _loc7_ = _loc6_ + 1;
                     break;
                  }
                  _loc6_++;
               }
               _loc3_.updatePosView(_loc7_);
            }
            else
            {
               _loc3_.updatePosView(-1);
            }
            _loc5_++;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

