package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.TimeVortexManager;
   import mvc.module.team.FreedomTeamModel;
   import mvc.module.timevortex.TimeVortexModel;
   import mvc.module.timevortex.TimeVortexTeamItemInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   
   public class TimeVortexCrackTeamItemView extends Sprite implements Disposeable
   {
      
      private var _leaderImg:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _line:Image;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _teamModel:FreedomTeamModel = FreedomTeamManager.instance.model;
      
      private var _data:TimeVortexTeamItemInfo;
      
      private var _lineVisible:Boolean;
      
      private var _filter:IFilterFormat;
      
      public function TimeVortexCrackTeamItemView(param1:Boolean = true)
      {
         _lineVisible = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leaderImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackTeamItemView.leaderImg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackTeamItemView.nameTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackTeamItemView.countTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackTeamItemView.line");
         _filter = new UIFilter();
         _line.visible = _lineVisible;
         clean();
         addChild(_leaderImg);
         addChild(_nameTxt);
         addChild(_countTxt);
         addChild(_line);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_leaderImg);
         _leaderImg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _filter = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : TimeVortexTeamItemInfo
      {
         return _data;
      }
      
      public function set data(param1:TimeVortexTeamItemInfo) : void
      {
         _data = param1;
         clean();
         if(data)
         {
            if(FreedomTeamManager.instance.hasTeam && data.userId == _teamModel.captainId)
            {
               _leaderImg.visible = true;
            }
            else
            {
               _leaderImg.visible = false;
            }
            _nameTxt.text = data.nickName;
            if(FreedomTeamManager.instance.hasTeam && !FreedomTeamManager.instance.memberIsOnline(data.userId))
            {
               _countTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
               _filter.setGrayFilter(_nameTxt);
               _filter.setGrayFilter(_countTxt);
            }
            else
            {
               _countTxt.text = LanguageMgr.GetTranslation("timevortex.view.TimeVortexAreaView.TipsTxt",data.leftCount,_model.crackChallengeRewardMax);
               _filter.setNormalFilter(_nameTxt);
               _filter.setNormalFilter(_countTxt);
            }
         }
      }
      
      private function clean() : void
      {
         _filter.setNormalFilter(_nameTxt);
         _filter.setNormalFilter(_countTxt);
         _leaderImg.visible = false;
         _nameTxt.text = "";
         _countTxt.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

