package apex.room
{
   import apex.ApexHelpFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ApexEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexRankModel;
   import yishi.manager.ApexManager;
   
   public class ApexRoomRightView extends Component
   {
      
      private var _rightViewBg:MutipleImage;
      
      private var _btnRoomRank:IconButton;
      
      private var _btnRoomTeam:IconButton;
      
      private var _txtRoomScore:FilterFrameText;
      
      private var _txtRoomMyRank:FilterFrameText;
      
      private var _txtRoomRightViewStr1:FilterFrameText;
      
      private var _txtRoomRightViewStr2:FilterFrameText;
      
      private var _txtRoomRightViewStr3:FilterFrameText;
      
      private var _btnRightViewHelp:BaseButton;
      
      private var _txtRoomRightViewTurn:FilterFrameText;
      
      private var _imgRoomRightViewTurn:ScaleFrameImage;
      
      private var rankDataList:Array;
      
      private var vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var rankModel:ApexRankModel;
      
      private var myGroup:int;
      
      private var teamFrame:Object;
      
      public function ApexRoomRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         rankModel = ApexManager.instance.model.apexRoomRankModel;
         _rightViewBg = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.rightViewBg");
         _btnRoomRank = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.btnRoomRank");
         _btnRoomTeam = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.btnRoomTeam");
         _txtRoomScore = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomScore");
         _txtRoomMyRank = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomMyRank");
         _txtRoomRightViewStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRightViewStr1");
         _txtRoomRightViewStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRightViewStr2");
         _txtRoomRightViewStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRightViewStr3");
         _btnRightViewHelp = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.btnRightViewHelp");
         _txtRoomRightViewTurn = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRightViewTurn");
         _imgRoomRightViewTurn = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.imgRoomRightViewTurn");
         addChild(_rightViewBg);
         addChild(_btnRoomRank);
         addChild(_btnRoomTeam);
         addChild(_txtRoomScore);
         addChild(_txtRoomMyRank);
         addChild(_txtRoomRightViewStr1);
         addChild(_txtRoomRightViewStr2);
         addChild(_txtRoomRightViewStr3);
         addChild(_btnRightViewHelp);
         addChild(_txtRoomRightViewTurn);
         addChild(_imgRoomRightViewTurn);
         _txtRoomRightViewStr1.text = LanguageMgr.GetTranslation("apexroom.rightView.str1");
         _txtRoomRightViewStr2.text = LanguageMgr.GetTranslation("apexroom.rightView.str2");
         _txtRoomRightViewStr3.text = LanguageMgr.GetTranslation("apexroom.rightView.str3");
         _imgRoomRightViewTurn.setFrame(ApexManager.instance.model.apexState.stage);
         if(rankModel && rankModel.myData)
         {
            _txtRoomScore.text = rankModel.myData.score + "";
            _txtRoomMyRank.text = rankModel.myData.rank + "";
            myGroup = rankModel.myData.group;
            _txtRoomRightViewTurn.text = LanguageMgr.GetTranslation("apexroom.rightView.str4",rankModel.myData.groupStr);
         }
         else
         {
            _txtRoomScore.text = "0";
            _txtRoomMyRank.text = LanguageMgr.GetTranslation("apex.rank.str7");
            _txtRoomRightViewTurn.text = "";
         }
         initRankArr();
      }
      
      private function initRankArr() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ApexRoomRankItem = null;
         if(vbox)
         {
            ObjectUtils.disposeObject(vbox);
            vbox = null;
         }
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
            _scrollPanel = null;
         }
         if(myGroup)
         {
            rankDataList = rankModel.getGroupAllData(myGroup);
         }
         if(rankDataList)
         {
            vbox = ComponentFactory.Instance.creatComponentByStylename("apexroom.rightView.vbox");
            addChild(vbox);
            _loc2_ = 0;
            while(_loc2_ < rankDataList.length)
            {
               _loc1_ = new ApexRoomRankItem();
               _loc1_.data = rankDataList[_loc2_];
               vbox.addChild(_loc1_);
               _loc2_++;
            }
            _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("apex.scrollPanel.roomRank");
            addChild(_scrollPanel);
            _scrollPanel.beginChanges();
            _scrollPanel.setView(vbox);
            _scrollPanel.invalidateViewport();
            vbox.commitChanges();
         }
      }
      
      private function addEvent() : void
      {
         _btnRoomTeam.addEventListener("click",onClickTeam);
         _btnRoomRank.addEventListener("click",onClickRank);
         _btnRightViewHelp.addEventListener("click",onClickHelp);
         ApexManager.instance.addEventListener("REFRESH_APEX_BATTLE_RANK",updateRank);
      }
      
      private function removeEvent() : void
      {
         _btnRoomTeam.removeEventListener("click",onClickTeam);
         _btnRoomRank.removeEventListener("click",onClickRank);
         _btnRightViewHelp.removeEventListener("click",onClickHelp);
         ApexManager.instance.removeEventListener("REFRESH_APEX_BATTLE_RANK",updateRank);
      }
      
      private function updateRank(param1:ApexEvent) : void
      {
         initRankArr();
      }
      
      private function onClickHelp(param1:MouseEvent) : void
      {
         var _loc2_:ApexHelpFrame = ComponentFactory.Instance.creatComponentByStylename("apex.room.helpFrame");
         _loc2_.show();
      }
      
      private function onClickRank(param1:MouseEvent) : void
      {
         ApexManager.instance.sendGetRank();
      }
      
      private function onClickTeam(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(teamFrame)
         {
            teamFrame.dispose();
            return;
         }
         teamFrame = ComponentFactory.Instance.creatComponentByStylename("core.ArmyManageFrame");
         teamFrame.addEventListener("dispose",__teamFrameDispose);
         teamFrame.show();
      }
      
      private function __teamFrameDispose(param1:Event) : void
      {
         teamFrame.removeEventListener("dispose",__teamFrameDispose);
         teamFrame = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rightViewBg);
         _rightViewBg = null;
         ObjectUtils.disposeObject(_btnRoomRank);
         _btnRoomRank = null;
         ObjectUtils.disposeObject(_btnRoomTeam);
         _btnRoomTeam = null;
         ObjectUtils.disposeObject(_txtRoomScore);
         _txtRoomScore = null;
         ObjectUtils.disposeObject(_txtRoomMyRank);
         _txtRoomMyRank = null;
         ObjectUtils.disposeObject(_txtRoomRightViewStr1);
         _txtRoomRightViewStr1 = null;
         ObjectUtils.disposeObject(_txtRoomRightViewStr2);
         _txtRoomRightViewStr2 = null;
         ObjectUtils.disposeObject(_txtRoomRightViewStr3);
         _txtRoomRightViewStr3 = null;
         ObjectUtils.disposeObject(_btnRightViewHelp);
         _btnRightViewHelp = null;
         ObjectUtils.disposeObject(_txtRoomRightViewTurn);
         _txtRoomRightViewTurn = null;
         ObjectUtils.disposeObject(_imgRoomRightViewTurn);
         _imgRoomRightViewTurn = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

