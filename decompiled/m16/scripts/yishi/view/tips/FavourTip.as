package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class FavourTip extends BaseTip
   {
      
      private var _font1:FilterFrameText;
      
      private var _font2:FilterFrameText;
      
      private var _font3:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _pcntTxt:FilterFrameText;
      
      private var _teamTxt:FilterFrameText;
      
      public function FavourTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _font1 = ComponentFactory.Instance.creatComponentByStylename("tips.favour.FontI");
         _font1.text = LanguageMgr.GetTranslation("yishi.view.tips.FavourTip.font1");
         _font2 = ComponentFactory.Instance.creatComponentByStylename("tips.favour.FontII");
         _font2.text = LanguageMgr.GetTranslation("yishi.view.tips.FavourTip.font2");
         _font3 = ComponentFactory.Instance.creatComponentByStylename("tips.favour.FontIII");
         _font3.text = LanguageMgr.GetTranslation("yishi.view.tips.FavourTip.font3");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("tips.favour.LevelTxt");
         _pcntTxt = ComponentFactory.Instance.creatComponentByStylename("tips.favour.pcntTxt");
         _teamTxt = ComponentFactory.Instance.creatComponentByStylename("tips.favour.teamTxt");
         addChild(_font1);
         addChild(_font3);
         _font3.y = 28;
         addChild(_levelTxt);
         addChild(_pcntTxt);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:UpgradeTemplateInfo = null;
         if(_data is ThaneInfo)
         {
            if(_data.friendGrade < 10)
            {
               _loc1_ = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_data.friendGrade + 1,6,0);
            }
            _levelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_data.friendGrade);
            if(_loc1_ && _data.friendGrade > 0)
            {
               _pcntTxt.text = _data.friendGp + " / " + _loc1_.Data;
            }
            else
            {
               _pcntTxt.text = "--";
            }
            _teamTxt.text = _data.friendGrade + "%";
         }
         _bg.width = 260;
         _bg.height = 85;
      }
      
      override public function dispose() : void
      {
         if(_font1)
         {
            ObjectUtils.disposeObject(_font1);
         }
         _font1 = null;
         if(_font2)
         {
            ObjectUtils.disposeObject(_font2);
         }
         _font2 = null;
         if(_font3)
         {
            ObjectUtils.disposeObject(_font3);
         }
         _font3 = null;
         if(_levelTxt)
         {
            ObjectUtils.disposeObject(_levelTxt);
         }
         _levelTxt = null;
         if(_pcntTxt)
         {
            ObjectUtils.disposeObject(_pcntTxt);
         }
         _pcntTxt = null;
         if(_teamTxt)
         {
            ObjectUtils.disposeObject(_teamTxt);
         }
         _teamTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

