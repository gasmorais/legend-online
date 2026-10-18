package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaPetRightItem;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaPetView extends Component
   {
      
      private var _petVbox:VBox;
      
      private var petList:Vector.<DreamArenaPetRightItem>;
      
      public function DreamArenaPetView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         _petVbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaPetView.petVbox");
         addChild(_petVbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:DreamArenaPetRightItem = null;
         var _loc1_:int = 0;
         petList = new Vector.<DreamArenaPetRightItem>();
         var _loc3_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(2);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = new DreamArenaPetRightItem(_loc1_ + 1);
            _loc2_.tempInfo = _loc3_[_loc1_];
            _loc2_.refreshSkillView();
            _petVbox.addChild(_loc2_);
            petList.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DreamArenaPetRightItem = null;
         _loc1_ = 0;
         while(_loc1_ < petList.length)
         {
            _loc2_ = petList[_loc1_] as DreamArenaPetRightItem;
            _loc2_.refreshSkillView();
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_petVbox);
         _petVbox = null;
         LogicUtils.disposeDisplayCollection(petList);
         petList = null;
         super.dispose();
      }
   }
}

