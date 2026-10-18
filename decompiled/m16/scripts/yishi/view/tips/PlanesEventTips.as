package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesEventTips extends BaseTip
   {
      
      private var titleText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var needGradeText:FilterFrameText;
      
      private var needEnergyText:FilterFrameText;
      
      private var eventTempInfo:PlanesEventsTemplateInfo;
      
      private var layerTempInfo:PlanesLayerTemplateInfo;
      
      public function PlanesEventTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.titleText");
         descText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.descText");
         needGradeText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.needGradeText");
         needEnergyText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.needEnergyText");
         addChild(titleText);
         addChild(descText);
         addChild(needGradeText);
         addChild(needEnergyText);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         cleanData();
         if(_data)
         {
            eventTempInfo = _data.eventTemp;
            layerTempInfo = _data.layerTemp;
            _loc1_ = int(PlanesWarManager.instance.model.getEventCostEnergyByResistance(layerTempInfo,eventTempInfo));
            titleText.text = eventTempInfo.Name;
            titleText.width = 180;
            titleText.y = 10 - (titleText.numLines - 1) * 10;
            if(eventTempInfo.Description != "")
            {
               descText.htmlText = eventTempInfo.Description;
            }
            if(eventTempInfo.NeedLevel != 0)
            {
               needGradeText.text = LanguageMgr.GetTranslation("PlanesEventTips.needGradeText.tipData",eventTempInfo.NeedLevel);
            }
            if(eventTempInfo.EnergyCost != 0 && eventTempInfo && layerTempInfo)
            {
               needEnergyText.text = LanguageMgr.GetTranslation("PlanesEventTips.needEnergyText.tipData",_loc1_);
            }
         }
         descText.height = descText.textHeight + 3;
         needGradeText.y = descText.y + descText.height + 5;
         needEnergyText.y = needGradeText.y + needGradeText.height + 5;
         _bg.width = 200;
         _bg.height = titleText.textHeight + descText.textHeight + needGradeText.textHeight + needEnergyText.textHeight + 50;
      }
      
      private function cleanData() : void
      {
         titleText.text = "";
         descText.text = "";
         needGradeText.text = "";
         needEnergyText.text = "";
      }
      
      override public function dispose() : void
      {
         if(titleText)
         {
            ObjectUtils.disposeObject(titleText);
         }
         titleText = null;
         if(descText)
         {
            ObjectUtils.disposeObject(descText);
         }
         descText = null;
         if(needGradeText)
         {
            ObjectUtils.disposeObject(needGradeText);
         }
         needGradeText = null;
         if(needEnergyText)
         {
            ObjectUtils.disposeObject(needEnergyText);
         }
         needEnergyText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

