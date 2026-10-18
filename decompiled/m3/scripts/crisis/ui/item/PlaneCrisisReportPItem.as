package crisis.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisGameOverPlayInfo;
   import yishi.view.community.HeadIconCell;
   
   public class PlaneCrisisReportPItem extends Sprite
   {
      
      private var _data:PlaneCrisisGameOverPlayInfo;
      
      private var _nikeNameTxt:FilterFrameText;
      
      private var _fragmentTxt:FilterFrameText;
      
      private var _actionNumTxt:FilterFrameText;
      
      private var _icon:HeadIconCell;
      
      public function PlaneCrisisReportPItem()
      {
         super();
         initView();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nikeNameTxt);
         _nikeNameTxt = null;
         ObjectUtils.disposeObject(_fragmentTxt);
         _fragmentTxt = null;
         ObjectUtils.disposeObject(_actionNumTxt);
         _actionNumTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      private function initView() : void
      {
         _nikeNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.reportNameTxt");
         _fragmentTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.report.fragmentTxt");
         _actionNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.report.actionTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.planeCrisis.IconCell");
         addChild(_icon);
         addChild(_nikeNameTxt);
         addChild(_fragmentTxt);
         addChild(_actionNumTxt);
         _icon.type = "head";
      }
      
      public function get data() : PlaneCrisisGameOverPlayInfo
      {
         return _data;
      }
      
      public function set data(param1:PlaneCrisisGameOverPlayInfo) : void
      {
         _data = param1;
         if(_data != null)
         {
            _nikeNameTxt.text = _data.nickName;
            _fragmentTxt.text = LanguageMgr.GetTranslation("planeCrisis.elargmentNum",_data.fragment);
            _actionNumTxt.text = LanguageMgr.GetTranslation("planeCrisis.leftPowNum",_data.actionNum);
            _icon.headId = _data.headId;
         }
      }
   }
}

