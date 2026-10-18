package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.AvengerBodyTempInfo;
   
   public class AvengerBodyPropItem extends Component
   {
      
      private var _liveText:FilterFrameText;
      
      private var _magicDefenceText:FilterFrameText;
      
      private var _defenceText:FilterFrameText;
      
      private var _attactText:FilterFrameText;
      
      private var _data:AvengerBodyTempInfo;
      
      public function AvengerBodyPropItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _liveText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyPropItem.liveText");
         _magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyPropItem.magicDefenceText");
         _defenceText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyPropItem.defenceText");
         _attactText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyPropItem.attactText");
         addChild(_attactText);
         addChild(_defenceText);
         addChild(_magicDefenceText);
         addChild(_liveText);
      }
      
      public function get data() : AvengerBodyTempInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerBodyTempInfo) : void
      {
         _data = param1;
         if(data)
         {
            _attactText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText11",data.PhyAttack);
            _defenceText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText12",data.PhyDefence);
            _magicDefenceText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText13",data.MagDefence);
            _liveText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText14",data.Health);
         }
         else
         {
            _attactText.text = "";
            _defenceText.text = "";
            _magicDefenceText.text = "";
            _liveText.text = "";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_liveText);
         _liveText = null;
         ObjectUtils.disposeObject(_magicDefenceText);
         _magicDefenceText = null;
         ObjectUtils.disposeObject(_defenceText);
         _defenceText = null;
         ObjectUtils.disposeObject(_attactText);
         _attactText = null;
         super.dispose();
      }
   }
}

