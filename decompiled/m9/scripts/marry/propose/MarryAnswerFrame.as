package marry.propose
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryProposeInfo;
   import mvc.module.marry.MarrySender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.HeadIconCell;
   
   public class MarryAnswerFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _agreeBtn:IconButton;
      
      private var _rejectBtn:TextButton;
      
      private var _data:MarryProposeInfo;
      
      private var _userId:int;
      
      private var _headCell:HeadIconCell;
      
      private var _ringBack:Image;
      
      private var _ringItem:BaseItemView;
      
      private var _name:FilterFrameText;
      
      private var _consortia:FilterFrameText;
      
      private var _grades:FilterFrameText;
      
      private var _input:FilterFrameText;
      
      private var _feelBack:Bitmap;
      
      private var _feelTxt:FilterFrameText;
      
      public function MarryAnswerFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,390);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.propose.MarryAnswerFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.bg2");
         _agreeBtn = ComponentFactory.Instance.creatComponentByStylename("MarryAnswerFrame.agreeBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("MarryAnswerFrame.rejectBtn");
         _headCell = ComponentFactory.Instance.creatCustomObject("marry.HeadCell");
         _ringBack = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.ringBack");
         _ringItem = ComponentFactory.Instance.creatCustomObject("marry.ringItem");
         _name = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.name");
         _consortia = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.consortia");
         _grades = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.grades");
         _input = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.input");
         _feelBack = ComponentFactory.Instance.creatBitmap("asset.marry.feelBg");
         _feelTxt = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.feelTxt");
         addToContent(_bg);
         addToContent(_agreeBtn);
         _agreeBtn.enable = false;
         addToContent(_rejectBtn);
         _rejectBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.reject");
         addToContent(_headCell);
         addToContent(_ringBack);
         addToContent(_ringItem);
         addToContent(_name);
         addToContent(_consortia);
         addToContent(_grades);
         addToContent(_input);
         _input.type = "dynamic";
         _input.mouseEnabled = false;
         addToContent(_feelBack);
         _feelBack.visible = false;
         addToContent(_feelTxt);
         _feelTxt.visible = false;
         _headCell.type = "head";
         setIcon();
      }
      
      private function setIcon() : void
      {
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 208033;
         _ringItem.data = _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            return;
         }
         _agreeBtn.enable = true;
         _name.text = _data.nickNameA;
         _consortia.text = _data.property4;
         _grades.text = _data.property3 + "";
         _input.text = _data.property5;
         _headCell.headId = _data.property6;
         if(friendInfo && friendInfo.friendGrade > 0)
         {
            _feelBack.visible = true;
            _feelTxt.visible = true;
            _feelTxt.text = friendInfo.friendGrade + "";
         }
         else
         {
            _feelBack.visible = false;
            _feelTxt.visible = false;
         }
      }
      
      private function get friendInfo() : ThaneInfo
      {
         return FriendManager.getInstance().getFriendById(_userId);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _agreeBtn.addEventListener("click",__agreeHandler);
         _rejectBtn.addEventListener("click",__rejectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_agreeBtn)
         {
            _agreeBtn.removeEventListener("click",__agreeHandler);
         }
         if(_rejectBtn)
         {
            _rejectBtn.removeEventListener("click",__rejectHandler);
         }
      }
      
      private function __agreeHandler(param1:MouseEvent) : void
      {
         MarrySender.proposeAnswer(_userId,true);
         dispose();
      }
      
      private function __rejectHandler(param1:MouseEvent) : void
      {
         MarrySender.proposeAnswer(_userId,false);
         dispose();
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
      
      private function __rewardHandler(param1:MouseEvent) : void
      {
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            _data = param1.frameData as MarryProposeInfo;
            if(_data)
            {
               _userId = _data.userIdA;
            }
         }
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_headCell)
         {
            _headCell.dispose();
         }
         _headCell = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_consortia)
         {
            _consortia.dispose();
         }
         _consortia = null;
         if(_grades)
         {
            _grades.dispose();
         }
         _grades = null;
         if(_input)
         {
            _input.dispose();
         }
         _input = null;
         if(_ringBack)
         {
            _ringBack.dispose();
         }
         _ringBack = null;
         if(_ringItem)
         {
            _ringItem.dispose();
         }
         _ringItem = null;
         if(_agreeBtn)
         {
            _agreeBtn.dispose();
         }
         _agreeBtn = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_feelTxt)
         {
            _feelTxt.dispose();
         }
         _feelTxt = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_rejectBtn)
         {
            _rejectBtn.dispose();
         }
         _rejectBtn = null;
         ObjectUtils.disposeObject(_feelBack);
         _feelBack = null;
         _data = null;
         super.dispose();
      }
   }
}

