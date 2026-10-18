package apex.team
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ApexEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexTeamData;
   import yishi.datas.ComponentGroupType;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ApexManager;
   import yishi.manager.EnterFrameManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexTeamView extends Frame implements IManualSize, IEnterFrame
   {
      
      private var _btnTeamUpdate:IconButton;
      
      private var _btnTeamCreate:IconButton;
      
      private var _txtTeamView1:FilterFrameText;
      
      private var _txtTeamViewInput:FilterFrameText;
      
      private var _btnTeamFind:BaseButton;
      
      private var _bit0:Bitmap;
      
      private var _bg:MutipleImage;
      
      private var _img1:ScaleBitmapImage;
      
      private var sp_team:Sprite;
      
      private var teams:Array;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _refreshTimeCountTxt:FilterFrameText;
      
      private var _lastTime:Number;
      
      private var _autoTimeCount:int = 0;
      
      private var _handTimeCount:int = 0;
      
      private var _countDiff:int = 1;
      
      public function ApexTeamView()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,771,619);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("apex.team.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("apex.team.framebg");
         _img1 = ComponentFactory.Instance.creatComponentByStylename("apex.team.img1");
         _btnTeamUpdate = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamUpdate");
         _btnTeamCreate = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamCreate");
         _txtTeamView1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamView1");
         _txtTeamViewInput = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamViewInput");
         _btnTeamFind = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamFind");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.team.bg");
         addToContent(_bg);
         addToContent(_img1);
         addToContent(_bit0);
         addToContent(_btnTeamUpdate);
         addToContent(_btnTeamCreate);
         addToContent(_txtTeamView1);
         addToContent(_txtTeamViewInput);
         addToContent(_btnTeamFind);
         sp_team = ComponentFactory.Instance.creatCustomObject("apex.team.teamContainer");
         addToContent(sp_team);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("apex.team.ScrollPanel");
         addToContent(_scrollPanel);
         _txtTeamView1.text = LanguageMgr.GetTranslation("apex.team.str1");
         _txtTeamViewInput.text = LanguageMgr.GetTranslation("apex.team.str2");
         _scrollPanel.beginChanges();
         _scrollPanel.setView(sp_team);
         _scrollPanel.vScrollbar.scrollValue = 0;
         _scrollPanel.invalidateViewport();
         _refreshTimeCountTxt = ComponentFactory.Instance.creatComponentByStylename("apex.team.refreshTimeCountTxt");
         addToContent(_refreshTimeCountTxt);
         initRefreshData();
         m.sendGetAllTeamData();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         _btnTeamCreate.addEventListener("click",onClickCreate);
         _btnTeamUpdate.addEventListener("click",onClickUpdate);
         _btnTeamFind.addEventListener("click",onClickFind);
         m.addEventListener("REFRESH_APEX_TERM_DATA",updateTeam);
         _txtTeamViewInput.addEventListener("click",onClickInput);
         m.addEventListener("REFRESH_MAIN_VIEW",refreshMainView);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         _btnTeamCreate.removeEventListener("click",onClickCreate);
         _btnTeamUpdate.removeEventListener("click",onClickUpdate);
         _btnTeamFind.removeEventListener("click",onClickFind);
         m.removeEventListener("REFRESH_APEX_TERM_DATA",updateTeam);
         _txtTeamViewInput.removeEventListener("click",onClickInput);
         m.removeEventListener("REFRESH_MAIN_VIEW",refreshMainView);
      }
      
      private function refreshMainView(param1:ApexEvent) : void
      {
         if(m.model.isSign)
         {
            dispose();
         }
      }
      
      private function initRefreshData() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = getTimer();
         var _loc3_:int = 0;
         if(m.model.refreshTime != -1)
         {
            _lastTime = m.model.refreshTime;
            _loc2_ = _loc1_ - _lastTime;
            _countDiff = _loc2_ / 1000;
            _loc3_ = 20 - _countDiff;
            if(_loc3_ > 0)
            {
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("apex.team.str13",_loc3_);
               _btnTeamUpdate.enable = false;
            }
         }
         else
         {
            _lastTime = _loc1_;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Number = getTimer();
         var _loc2_:Number = _loc1_ - _lastTime;
         var _loc3_:int = 0;
         if(_loc2_ >= 1000)
         {
            _countDiff = _loc2_ / 1000;
            _autoTimeCount += _countDiff;
            if(!_btnTeamUpdate.enable)
            {
               _handTimeCount += _countDiff;
               _loc3_ = 20 - _handTimeCount;
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("apex.team.str13",_loc3_);
            }
            _lastTime = _loc1_;
         }
         if(!_btnTeamUpdate.enable && _handTimeCount >= 20)
         {
            _handTimeCount = 0;
            m.model.refreshTime = -1;
            _btnTeamUpdate.enable = true;
            _refreshTimeCountTxt.text = "";
         }
      }
      
      protected function onClickInput(param1:MouseEvent) : void
      {
         if(_txtTeamViewInput.text == LanguageMgr.GetTranslation("apex.team.str2"))
         {
            _txtTeamViewInput.text = "";
         }
      }
      
      private function updateTeam(param1:ApexEvent = null) : void
      {
         var _loc5_:ApexTeamItem = null;
         var _loc2_:ApexTeamData = null;
         var _loc3_:int = 0;
         clean();
         teams = [];
         var _loc4_:int = 0;
         if(m.model.myTeam)
         {
            _loc5_ = new ApexTeamItem(m.model.myTeam);
            sp_team.addChild(_loc5_);
            _loc5_.y = _loc4_;
            _loc4_++;
            teams.push(_loc5_);
         }
         if(m.model.teams)
         {
            _loc3_ = 0;
            while(_loc3_ < m.model.teams.size)
            {
               _loc2_ = m.model.teams.getValueByIndex(m.model.teams.size - _loc3_ - 1) as ApexTeamData;
               if(!(m.model.myTeam && _loc2_ == m.model.myTeam))
               {
                  _loc5_ = new ApexTeamItem(_loc2_);
                  sp_team.addChild(_loc5_);
                  _loc5_.y = _loc4_ * 205;
                  _loc4_++;
                  teams.push(_loc5_);
               }
               _loc3_++;
            }
         }
         _scrollPanel.beginChanges();
         _scrollPanel.setView(sp_team);
         _scrollPanel.invalidateViewport();
      }
      
      private function clean() : void
      {
         var _loc1_:* = null;
         if(teams)
         {
            for each(_loc1_ in teams)
            {
               _loc1_.dispose();
            }
            teams = null;
         }
      }
      
      public function get m() : ApexManager
      {
         return ApexManager.instance;
      }
      
      private function onClickFind(param1:MouseEvent) : void
      {
         var _loc3_:ApexTeamItem = null;
         var _loc2_:ApexTeamData = null;
         if(_txtTeamViewInput.text == LanguageMgr.GetTranslation("apex.team.str2") || _txtTeamViewInput.text == "")
         {
            updateTeam();
            return;
         }
         clean();
         teams = [];
         if(m.model.teams)
         {
            _loc2_ = m.model.teams.getValue(int(_txtTeamViewInput.text)) as ApexTeamData;
         }
         if(_loc2_)
         {
            _loc3_ = new ApexTeamItem(_loc2_);
            sp_team.addChild(_loc3_);
            teams.push(_loc3_);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.team.str9"));
         }
      }
      
      private function onClickUpdate(param1:MouseEvent) : void
      {
         _txtTeamViewInput.text = LanguageMgr.GetTranslation("apex.team.str2");
         m.model.refreshTime = getTimer();
         _btnTeamUpdate.enable = false;
         _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("apex.team.str13",20);
         m.sendGetAllTeamData();
      }
      
      private function onClickCreate(param1:MouseEvent) : void
      {
         m.sendCreateTeam();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnTeamUpdate);
         _btnTeamUpdate = null;
         ObjectUtils.disposeObject(_btnTeamCreate);
         _btnTeamCreate = null;
         ObjectUtils.disposeObject(_txtTeamView1);
         _txtTeamView1 = null;
         ObjectUtils.disposeObject(_txtTeamViewInput);
         _txtTeamViewInput = null;
         ObjectUtils.disposeObject(_btnTeamFind);
         _btnTeamFind = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_refreshTimeCountTxt);
         _refreshTimeCountTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

