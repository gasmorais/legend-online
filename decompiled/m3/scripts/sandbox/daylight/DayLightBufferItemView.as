package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sandbox.net.DayLightOuterManager;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DayLightBufferItemView extends Sprite implements Disposeable
   {
      
      private var _buffIcon:BaseIconView;
      
      private var _buffTxt:FilterFrameText;
      
      private var _buffUseBtn:BaseButton;
      
      private var _buffExchangeBtn:BaseButton;
      
      private var _count:int;
      
      private var _data:CampaignBufferTemp;
      
      public function DayLightBufferItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _buffIcon = ComponentFactory.Instance.creatCustomObject("daylight.DayLightBufferItemView.buffIcon");
         _buffTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBufferItemView.buffTxt");
         _buffUseBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBufferItemView.buffUseBtn");
         _buffExchangeBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightBufferItemView.buffExchangeBtn");
         _buffIcon.visible = false;
         _buffTxt.visible = false;
         _buffUseBtn.visible = false;
         _buffExchangeBtn.visible = false;
         addChild(_buffIcon);
         addChild(_buffTxt);
         addChild(_buffUseBtn);
         addChild(_buffExchangeBtn);
      }
      
      private function uninitView() : void
      {
         if(_buffIcon)
         {
            ObjectUtils.disposeObject(_buffIcon);
         }
         _buffIcon = null;
         if(_buffTxt)
         {
            ObjectUtils.disposeObject(_buffTxt);
         }
         _buffTxt = null;
         if(_buffUseBtn)
         {
            ObjectUtils.disposeObject(_buffUseBtn);
         }
         _buffUseBtn = null;
         if(_buffExchangeBtn)
         {
            ObjectUtils.disposeObject(_buffExchangeBtn);
         }
         _buffExchangeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _buffUseBtn.addEventListener("click",__buffUseBtnClickHandler);
         _buffExchangeBtn.addEventListener("click",__buffExchangeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _buffUseBtn.removeEventListener("click",__buffUseBtnClickHandler);
         _buffExchangeBtn.removeEventListener("click",__buffExchangeBtnClickHandler);
      }
      
      private function __buffUseBtnClickHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            DayLightOuterManager.useSkill(data.TemplateId);
         }
      }
      
      private function __buffExchangeBtnClickHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            DayLightOuterManager.buySkill(data.TemplateId);
         }
      }
      
      public function get data() : CampaignBufferTemp
      {
         return _data;
      }
      
      public function set data(param1:CampaignBufferTemp) : void
      {
         _data = param1;
         clear();
         if(data)
         {
            _buffIcon.icon = IconFactory.getCommonIconPath(data.Icon);
            _buffIcon.tipData = data.Description;
            _buffTxt.text = data.TemplateName + " X" + _count;
            _buffIcon.visible = true;
            _buffTxt.visible = true;
            if(data.TemplateId != 410205)
            {
               _buffUseBtn.visible = true;
               _buffExchangeBtn.visible = true;
            }
         }
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         _buffTxt.text = data.TemplateName + " X" + _count;
      }
      
      private function clear() : void
      {
         _buffIcon.visible = false;
         _buffTxt.visible = false;
         _buffUseBtn.visible = false;
         _buffExchangeBtn.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

