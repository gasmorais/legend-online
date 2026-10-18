package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.manager.PetHallowsManager;
   
   public class PetHallowsLeftItem extends Component
   {
      
      private var itemImage:ScaleFrameImage;
      
      private var stateText:FilterFrameText;
      
      private var _data:PetHallowsTemplateInfo;
      
      public function PetHallowsLeftItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         itemImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLeftItem.itemImage");
         stateText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLeftItem.stateText");
         addChild(itemImage);
         addChild(stateText);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         model.selectedHallowsTemp = data;
      }
      
      public function get data() : PetHallowsTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:PetHallowsTemplateInfo) : void
      {
         var _loc2_:PetHallowsInfo = null;
         _data = param1;
         if(_data)
         {
            this.buttonMode = true;
            _loc2_ = model.getHallowsInfoByHallowsType(_data.HallowType);
         }
         if(_loc2_)
         {
            stateText.htmlText = LanguageMgr.GetTranslation("PetHallowsLeftItem.stateText.hasactive");
         }
         else
         {
            stateText.htmlText = LanguageMgr.GetTranslation("PetHallowsLeftItem.stateText.noactive");
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(!data)
         {
            return;
         }
         param1 ? itemImage.setFrame(data.HallowType) : itemImage.setFrame(data.HallowType + 3);
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(itemImage);
         itemImage = null;
         ObjectUtils.disposeObject(itemImage);
         itemImage = null;
         super.dispose();
      }
   }
}

