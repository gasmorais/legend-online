package ui.tasktracebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class HigherGradeOpenTipView extends Sprite
   {
      
      private var _bg:ScaleUpDownImage;
      
      private var _icon:BaseIconView;
      
      private var _openContentTxt:GradientText;
      
      private var _openDescTxt:FilterFrameText;
      
      private var _dataList:Array;
      
      private var _curData:Object;
      
      public function HigherGradeOpenTipView()
      {
         super();
         initData();
         initView();
         addEvent();
         refreshTip();
      }
      
      private function initData() : void
      {
         _dataList = [];
         _dataList.push({
            "grade":"12",
            "content":"HigherGradeOpenTipView.content14",
            "desc":"HigherGradeOpenTipView.desc14",
            "icon":"/Upcoming/maze.png"
         });
         _dataList.push({
            "grade":"13",
            "content":"HigherGradeOpenTipView.content6",
            "desc":"HigherGradeOpenTipView.desc6",
            "icon":"/Upcoming/sociaty.png"
         });
         _dataList.push({
            "grade":"14",
            "content":"HigherGradeOpenTipView.content7",
            "desc":"HigherGradeOpenTipView.desc7",
            "icon":"/Upcoming/gold.png"
         });
         _dataList.push({
            "grade":"15",
            "content":"HigherGradeOpenTipView.content8",
            "desc":"HigherGradeOpenTipView.desc8",
            "icon":"/Upcoming/store.png"
         });
         _dataList.push({
            "grade":"16",
            "content":"HigherGradeOpenTipView.content21",
            "desc":"HigherGradeOpenTipView.desc21",
            "icon":"/Upcoming/mount.png"
         });
         _dataList.push({
            "grade":"17",
            "content":"HigherGradeOpenTipView.content9",
            "desc":"HigherGradeOpenTipView.desc9",
            "icon":"/Upcoming/reward.png"
         });
         _dataList.push({
            "grade":"18",
            "content":"HigherGradeOpenTipView.content16",
            "desc":"HigherGradeOpenTipView.desc16",
            "icon":"/Upcoming/star.png"
         });
         _dataList.push({
            "grade":"19",
            "content":"HigherGradeOpenTipView.content11",
            "desc":"HigherGradeOpenTipView.desc11",
            "icon":"/Upcoming/store.png"
         });
         _dataList.push({
            "grade":"20",
            "content":"HigherGradeOpenTipView.content12",
            "desc":"HigherGradeOpenTipView.desc12",
            "icon":"/Upcoming/worldBoss.png"
         });
         _dataList.push({
            "grade":"22",
            "content":"HigherGradeOpenTipView.content13",
            "desc":"HigherGradeOpenTipView.desc13",
            "icon":"/Upcoming/challenge.png"
         });
         _dataList.push({
            "grade":"24",
            "content":"HigherGradeOpenTipView.content15",
            "desc":"HigherGradeOpenTipView.desc15",
            "icon":"/Upcoming/sould.png"
         });
         _dataList.push({
            "grade":"25",
            "content":"HigherGradeOpenTipView.content26",
            "desc":"HigherGradeOpenTipView.desc26",
            "icon":"/Upcoming/Mysterious.png"
         });
         _dataList.push({
            "grade":"26",
            "content":"HigherGradeOpenTipView.content17",
            "desc":"HigherGradeOpenTipView.desc17",
            "icon":"/Upcoming/Mysterious.png"
         });
         _dataList.push({
            "grade":"30",
            "content":"HigherGradeOpenTipView.content18",
            "desc":"HigherGradeOpenTipView.desc18",
            "icon":"/Upcoming/appell.png"
         });
         _dataList.push({
            "grade":"35",
            "content":"HigherGradeOpenTipView.content19",
            "desc":"HigherGradeOpenTipView.desc19",
            "icon":"/Upcoming/soul.png"
         });
         _dataList.push({
            "grade":"36",
            "content":"HigherGradeOpenTipView.content27",
            "desc":"HigherGradeOpenTipView.desc27",
            "icon":"/Upcoming/marriage.png"
         });
         _dataList.push({
            "grade":"38",
            "content":"HigherGradeOpenTipView.content20",
            "desc":"HigherGradeOpenTipView.desc20",
            "icon":"/Upcoming/skill.png"
         });
         _dataList.push({
            "grade":"40",
            "content":"HigherGradeOpenTipView.content28",
            "desc":"HigherGradeOpenTipView.desc28",
            "icon":"/Upcoming/dragon.png"
         });
         _dataList.push({
            "grade":"46",
            "content":"HigherGradeOpenTipView.content22",
            "desc":"HigherGradeOpenTipView.desc22",
            "icon":"/Upcoming/Trial.png"
         });
         _dataList.push({
            "grade":"50",
            "content":"HigherGradeOpenTipView.content23",
            "desc":"HigherGradeOpenTipView.desc23",
            "icon":"/Upcoming/pet.png"
         });
         _dataList.push({
            "grade":"55",
            "content":"HigherGradeOpenTipView.content25",
            "desc":"HigherGradeOpenTipView.desc25",
            "icon":"/Upcoming/fate.png"
         });
         _dataList.push({
            "grade":"60",
            "content":"HigherGradeOpenTipView.content29",
            "desc":"HigherGradeOpenTipView.desc29",
            "icon":"/Upcoming/level.png"
         });
         _dataList.push({
            "grade":"70",
            "content":"HigherGradeOpenTipView.content30",
            "desc":"HigherGradeOpenTipView.desc30",
            "icon":"/Upcoming/refinery.png"
         });
         _dataList.push({
            "grade":"80",
            "content":"HigherGradeOpenTipView.content31",
            "desc":"HigherGradeOpenTipView.desc31",
            "icon":"/Upcoming/upgrade.png"
         });
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.HigherGradeOpenTipBg");
         _icon = ComponentFactory.Instance.creatCustomObject("tasktracebar.HigherGradeOpenTipIcon");
         _openContentTxt = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.HigherGradeOpenTipＯpenContentTxt");
         _openDescTxt = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.HigherGradeOpenTipＯpenDescTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_openContentTxt);
         addChild(_openDescTxt);
      }
      
      private function addEvent() : void
      {
         thane.addEventListener("THANE_LEVEL_UPDATE",__thaneUpgradeHandler);
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("THANE_LEVEL_UPDATE",__thaneUpgradeHandler);
      }
      
      private function __thaneUpgradeHandler(param1:PlayerEvent) : void
      {
         refreshTip();
      }
      
      public function refreshTip() : void
      {
         for each(_curData in _dataList)
         {
            if(thane.grades < _curData.grade)
            {
               _icon.icon = IconFactory.getCommonIconPath(_curData.icon);
               _openContentTxt.text = LanguageMgr.GetTranslation(_curData.content) + "  " + LanguageMgr.GetTranslation("HigherGradeOpenTipView.openGrade",_curData.grade);
               _openDescTxt.text = LanguageMgr.GetTranslation(_curData.desc);
               _openContentTxt.textField.numLines == 2 ? (_openContentTxt.y = -11) : (_openContentTxt.y = 0);
               break;
            }
            _curData = null;
         }
         if(!_curData)
         {
            dispose();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_openContentTxt);
         _openContentTxt = null;
         ObjectUtils.disposeObject(_openDescTxt);
         _openDescTxt = null;
         if(_dataList)
         {
            _dataList.length = 0;
         }
         _dataList = null;
         _curData = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

