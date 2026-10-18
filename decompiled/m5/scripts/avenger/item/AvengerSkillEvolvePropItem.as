package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class AvengerSkillEvolvePropItem extends Component
   {
      
      private var _propText6:FilterFrameText;
      
      private var _propText5:FilterFrameText;
      
      private var _propText4:FilterFrameText;
      
      private var _propText3:FilterFrameText;
      
      private var _propText2:FilterFrameText;
      
      private var _propText1:FilterFrameText;
      
      private var type:int;
      
      public function AvengerSkillEvolvePropItem(param1:int)
      {
         super();
         type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _propText6 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText6");
         _propText5 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText5");
         _propText4 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText4");
         _propText3 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText3");
         _propText2 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText2");
         _propText1 = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolvePropItem.propText1");
         addChild(_propText1);
         addChild(_propText2);
         addChild(_propText3);
         addChild(_propText4);
         addChild(_propText5);
         addChild(_propText6);
      }
      
      public function refreshTextValue(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            this["_propText" + _loc2_].htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText" + type + _loc2_,param1[_loc2_ - 1]);
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_propText6);
         _propText6 = null;
         ObjectUtils.disposeObject(_propText5);
         _propText5 = null;
         ObjectUtils.disposeObject(_propText4);
         _propText4 = null;
         ObjectUtils.disposeObject(_propText3);
         _propText3 = null;
         ObjectUtils.disposeObject(_propText2);
         _propText2 = null;
         ObjectUtils.disposeObject(_propText1);
         _propText1 = null;
         super.dispose();
      }
   }
}

