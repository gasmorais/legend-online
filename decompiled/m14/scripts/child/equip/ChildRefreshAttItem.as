package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import pet.equipstore.refinery.PetEquipRefinerySkillItem;
   
   public class ChildRefreshAttItem extends PetEquipRefinerySkillItem
   {
      
      public function ChildRefreshAttItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _refineryAttributeSelected = ComponentFactory.Instance.creatComponentByStylename("ChildEquipAttItem.selectBtn");
         _refineryAttributeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.refineryAttributeTxt");
         _refineryAttributeNewTxt = ComponentFactory.Instance.creatComponentByStylename("pet.refineryAttributeNewTxt");
         addChild(_refineryAttributeSelected);
         addChild(_refineryAttributeTxt);
         addChild(_refineryAttributeNewTxt);
      }
   }
}

