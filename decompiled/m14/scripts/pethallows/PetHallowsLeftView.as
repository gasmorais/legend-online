package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import utils.LogicUtils;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.manager.PetHallowsManager;
   
   public class PetHallowsLeftView extends Component
   {
      
      private var itemVbox:VBox;
      
      private var itemList:Vector.<PetHallowsLeftItem>;
      
      public function PetHallowsLeftView()
      {
         super();
         initView();
         initListView();
      }
      
      public function setFirstSelect() : void
      {
         model.selectedHallowsTemp = itemList[0].data;
      }
      
      private function initView() : void
      {
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLeftView.itemVbox");
         addChild(itemVbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetHallowsLeftItem = null;
         itemList = new Vector.<PetHallowsLeftItem>();
         _loc2_ = 0;
         while(_loc2_ < model.hallowsTempList.length)
         {
            _loc1_ = new PetHallowsLeftItem();
            _loc1_.data = model.hallowsTempList[_loc2_];
            itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            itemList[_loc1_].data = model.hallowsTempList[_loc1_];
            if(itemList[_loc1_].data && model.selectedHallowsTemp && itemList[_loc1_].data.TemplateId == model.selectedHallowsTemp.TemplateId)
            {
               itemList[_loc1_].selected = true;
            }
            else
            {
               itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(itemVbox);
         itemVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         super.dispose();
      }
   }
}

