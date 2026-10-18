package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.DayGuideEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.VIPManager;
   import mvc.module.dayGuide.LeedInfo;
   
   public class ProjectItem extends Component implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _addTxt:FilterFrameText;
      
      private var _data:LeedInfo;
      
      private var _statusTxt:FilterFrameText;
      
      public function ProjectItem()
      {
         super();
         buttonMode = true;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ProjectItemBg");
         _bg.setFrame(1);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ProjectTxt1");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ProjectTxt2");
         _addTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.AddActiveNumTxt");
         _statusTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.statusTxt");
         addChild(_bg);
         addChild(_txt1);
         addChild(_txt2);
         addChild(_addTxt);
         addChild(_statusTxt);
         _statusTxt.setFrame(3);
         _txt1.setFrame(1);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_addTxt);
         _addTxt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_statusTxt);
         _statusTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onOverHandler);
         addEventListener("rollOut",__onOutHandler);
         addEventListener("click",__onClickHandler);
         if(_data)
         {
            _data.addEventListener("LEEDINFO_CHANGE",__onPropertyChange);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onOverHandler);
         removeEventListener("rollOut",__onOutHandler);
         removeEventListener("click",__onClickHandler);
         if(_data)
         {
            _data.removeEventListener("LEEDINFO_CHANGE",__onPropertyChange);
         }
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022",false,false);
         DayGuideManager.instance.switchScene(_data.templateId);
      }
      
      private function __onPropertyChange(param1:DayGuideEvent) : void
      {
         if(!_data || !_data.templateInfo)
         {
            return;
         }
         _txt2.text = _data.currentCount + "/" + _data.templateInfo.PassCount;
      }
      
      public function get data() : LeedInfo
      {
         return _data;
      }
      
      public function set data(param1:LeedInfo) : void
      {
         _data = param1;
         _txt1.setFrame(1);
         addEvent();
         if(_data.templateId == -1)
         {
            _txt1.text = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.vipLogin");
            _txt2.visible = false;
            _addTxt.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.addTxt"," + " + VIPManager.Instance.model.vipActivePrivilege);
            _statusTxt.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
            _addTxt.setFrame(1);
            if(_data.isComplete)
            {
               _txt1.setFrame(2);
               _statusTxt.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
               _addTxt.setFrame(3);
            }
         }
         else
         {
            _txt1.text = _data.templateInfo.Title;
            _txt2.visible = true;
            _txt2.text = _data.currentCount + "/" + _data.templateInfo.PassCount;
            _addTxt.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.addTxt"," + " + _data.templateInfo.Num);
            _statusTxt.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
            _addTxt.setFrame(1);
            if(_data.isComplete)
            {
               _txt1.setFrame(2);
               _statusTxt.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
               _addTxt.setFrame(3);
            }
         }
         initTipData();
      }
      
      private function initTipData() : void
      {
         var _loc1_:int = 0;
         if(_data.templateId == -1)
         {
            _loc1_ = int(VIPManager.Instance.model.vipActivePrivilege);
         }
         else
         {
            _loc1_ = int(_data.templateInfo.Num);
         }
         switch(_data.templateId)
         {
            case -1:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData00",_loc1_);
               break;
            case 1:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData01",_loc1_);
               break;
            case 5:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData05",_data.templateInfo.PassCount,_loc1_);
               break;
            case 8:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData08",_data.templateInfo.PassCount,_loc1_);
               break;
            case 9:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData09",_data.templateInfo.PassCount,_loc1_);
               break;
            case 10:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData10",_data.templateInfo.PassCount,_loc1_);
               break;
            case 12:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData12",_data.templateInfo.PassCount,_loc1_);
               break;
            case 13:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData13",_data.templateInfo.PassCount,_loc1_);
               break;
            case 15:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData15",_data.templateInfo.PassCount,_loc1_);
               break;
            case 16:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData16",_data.templateInfo.PassCount,_loc1_);
               break;
            case 17:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData17",_data.templateInfo.PassCount,_loc1_);
               break;
            case 19:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData19",_data.templateInfo.PassCount,_loc1_);
               break;
            case 23:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData23",_data.templateInfo.PassCount,_loc1_);
               break;
            case 24:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData24",_data.templateInfo.PassCount,_loc1_);
               break;
            case 25:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData25",_data.templateInfo.PassCount,_loc1_);
               break;
            case 27:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData27",_data.templateInfo.PassCount,_loc1_);
               break;
            case 28:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData28",_data.templateInfo.PassCount,_loc1_);
               break;
            case 29:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData29",_data.templateInfo.PassCount,_loc1_);
               break;
            case 30:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData30",_data.templateInfo.PassCount,_loc1_);
               break;
            case 33:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData33",_data.templateInfo.PassCount,_loc1_);
               break;
            case 34:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData34",_data.templateInfo.PassCount,_loc1_);
               break;
            case 39:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData39",_data.templateInfo.PassCount,_loc1_);
               break;
            case 40:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData40",_data.templateInfo.PassCount,_loc1_);
               break;
            case 41:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData41",_data.templateInfo.PassCount,_loc1_);
               break;
            case 42:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData42",_data.templateInfo.PassCount,_loc1_);
               break;
            case 43:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData43",_data.templateInfo.PassCount,_loc1_);
               break;
            case 44:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData44",_data.templateInfo.PassCount,_loc1_);
               break;
            case 45:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData45",_data.templateInfo.PassCount,_loc1_);
               break;
            case 46:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData46",_data.templateInfo.PassCount,_loc1_);
               break;
            case 47:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData47",_data.templateInfo.PassCount,_loc1_);
               break;
            case 48:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData48",_data.templateInfo.PassCount,_loc1_);
               break;
            case 49:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData49",_data.templateInfo.PassCount,_loc1_);
               break;
            case 51:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData51",_data.templateInfo.PassCount,_loc1_);
               break;
            case 52:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData52",_data.templateInfo.PassCount,_loc1_);
               break;
            case 53:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData53",_data.templateInfo.PassCount,_loc1_);
               break;
            case 54:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData54",_data.templateInfo.PassCount,_loc1_);
               break;
            case 55:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData55",_data.templateInfo.PassCount,_loc1_);
               break;
            case 56:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData56",_data.templateInfo.PassCount,_loc1_);
               break;
            case 57:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData57",_data.templateInfo.PassCount,_loc1_);
               break;
            case 58:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData58",_data.templateInfo.PassCount,_loc1_);
               break;
            case 59:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData59",_data.templateInfo.PassCount,_loc1_);
               break;
            case 60:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData60",_data.templateInfo.PassCount,_loc1_);
               break;
            case 61:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData61",_data.templateInfo.PassCount,_loc1_);
               break;
            case 62:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData62",_data.templateInfo.PassCount,_loc1_);
               break;
            case 63:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData63",_data.templateInfo.PassCount,_loc1_);
               break;
            case 64:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData64",_data.templateInfo.PassCount,_loc1_);
               break;
            case 65:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData65",_data.templateInfo.PassCount,_loc1_);
               break;
            case 66:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData66",_data.templateInfo.PassCount,_loc1_);
               break;
            case 67:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData67",_data.templateInfo.PassCount,_loc1_);
               break;
            case 68:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData68",_data.templateInfo.PassCount,_loc1_);
               break;
            case 69:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData69",_loc1_);
               break;
            case 70:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData70",_data.templateInfo.PassCount,_loc1_);
               break;
            case 71:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData71",_data.templateInfo.PassCount,_loc1_);
               break;
            case 72:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData72",_data.templateInfo.PassCount,_loc1_);
               break;
            case 73:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData73",_data.templateInfo.PassCount,_loc1_);
               break;
            case 74:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData74",_data.templateInfo.PassCount,_loc1_);
               break;
            case 75:
               tipData = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.tipData75",_data.templateInfo.PassCount,_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

