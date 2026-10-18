package childspiritexpedition.formation
{
   import childformation.ChildCommonFormationItemView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.SpiritExpeditionManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.childspiritexpedition.SpiritExpeditionChildInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SpiritExpeditionFormationFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _back:MutipleImage;
      
      private var _headBox:HBox;
      
      private var _skillBox:VBox;
      
      private var _alertText:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var avatarList:Vector.<ChildCommonFormationItemView>;
      
      private var headList:Vector.<SpiritExpeditionNSHeadItem>;
      
      private var skillList:Vector.<SpiritExpeditionChildSkillItem>;
      
      private var _formationType:int;
      
      private var preFormation:String;
      
      public function SpiritExpeditionFormationFrame()
      {
         super();
         initView();
         initOhterView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,994,514);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.back");
         _headBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.headBox");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.skillBox");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.alertText");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFormationFrame.helpBtn");
         addToContent(_border);
         addToContent(_back);
         addToContent(_helpBtn);
         addToContent(_alertText);
         _alertText.text = LanguageMgr.GetTranslation("SpiritExpeditionFormationFrame.alertText.text");
      }
      
      private function initOhterView() : void
      {
         var _loc6_:int = 0;
         var _loc4_:ChildCommonFormationItemView = null;
         var _loc1_:SpiritExpeditionNSHeadItem = null;
         var _loc7_:SpiritExpeditionChildSkillItem = null;
         avatarList = new Vector.<ChildCommonFormationItemView>();
         var _loc3_:Array = [{
            "x":276,
            "y":196
         },{
            "x":234,
            "y":254
         },{
            "x":191,
            "y":306
         },{
            "x":141,
            "y":356
         },{
            "x":485,
            "y":196
         },{
            "x":447,
            "y":254
         },{
            "x":401,
            "y":306
         },{
            "x":351,
            "y":356
         }];
         var _loc5_:Array = [3,6,9,12,1,4,7,10];
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc4_ = new ChildCommonFormationItemView(_loc5_[_loc6_]);
            _loc4_.x = _loc3_[_loc6_].x + 20;
            _loc4_.y = _loc3_[_loc6_].y;
            addToContent(_loc4_);
            avatarList.push(_loc4_);
            _loc6_++;
         }
         var _loc2_:Array = nsModel.nsTempList;
         _loc2_.sort(sortChild);
         headList = new Vector.<SpiritExpeditionNSHeadItem>();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc1_ = new SpiritExpeditionNSHeadItem(1);
            _loc1_.formationType = 2;
            _loc1_.tempInfo = _loc2_[_loc6_];
            _headBox.addChild(_loc1_);
            headList.push(_loc1_);
            _loc6_++;
         }
         addToContent(_headBox);
         skillList = new Vector.<SpiritExpeditionChildSkillItem>();
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc7_ = new SpiritExpeditionChildSkillItem();
            _skillBox.addChild(_loc7_);
            skillList.push(_loc7_);
            _loc6_++;
         }
         addToContent(_skillBox);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         MsgMan.addObserver("FORMATION_INFO_UPDATE",this,__formationChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         MsgMan.removeObserver("FORMATION_INFO_UPDATE",this,__formationChangeHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("spiritExpedition.SpiritExpeditionChapterFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __formationChangeHandler(param1:String, param2:Object) : void
      {
         preFormation = "";
         refreshView();
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:ChildCommonFormationItemView in avatarList)
         {
            _loc2_.setBottomVisible(true);
            _loc2_.dark();
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_:ChildCommonFormationItemView in avatarList)
         {
            _loc2_.setBottomVisible(false);
            _loc2_.normal();
            if(_loc2_.data)
            {
               _loc3_[_loc2_.pos] = _loc2_.data.childId;
            }
            else
            {
               _loc3_[_loc2_.pos] = -1;
            }
         }
         updateToPlayerInfo(_loc3_);
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = nsModel.nsTempList;
         _loc2_.sort(sortChild);
         _loc3_ = 0;
         while(_loc3_ < headList.length)
         {
            headList[_loc3_].formationType = _formationType;
            headList[_loc3_].tempInfo = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < skillList.length)
         {
            skillList[_loc3_].data = _loc3_ < model.enterWarList.length ? model.enterWarList[_loc3_] : null;
            _loc3_++;
         }
         for each(var _loc1_:ChildCommonFormationItemView in avatarList)
         {
            _loc1_.setBottomVisible(false);
            _loc1_.formationType = _formationType;
            _loc1_.data = model.getChildDataByPos(_loc1_.pos);
         }
      }
      
      private function sortChild(param1:ChildTempInfo, param2:ChildTempInfo) : int
      {
         var _loc3_:SpiritExpeditionChildInfo = model.getChildInfoByJob(param1.JobType);
         var _loc4_:SpiritExpeditionChildInfo = model.getChildInfoByJob(param2.JobType);
         if(_loc3_ && _loc4_ == null)
         {
            return -1;
         }
         if(_loc3_ == null && _loc4_)
         {
            return 1;
         }
         return param1.JobType <= param2.JobType ? -1 : 1;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("ChildPveFrame.title");
         if(param1 && param1.frameData)
         {
            _formationType = int(param1.frameData);
         }
         refreshView();
      }
      
      private function updateToPlayerInfo(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         for(var _loc4_:String in param1)
         {
            _loc3_ = int(param1[_loc4_]);
            if(_loc3_ > 0)
            {
               _loc2_ += _loc3_ + "," + _loc4_ + "|";
            }
         }
         _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf("|"));
         if(preFormation != _loc2_)
         {
            SpiritExpeditionManager.instance.sendExpeditionEditFormation(_loc2_);
            preFormation = _loc2_;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         DragManager.getInstance().stopDrag();
         KeyBoardRegister.instance.keyEnable = false;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_headBox);
         _headBox = null;
         ObjectUtils.disposeObject(_skillBox);
         _headBox = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         LogicUtils.disposeDisplayCollection(avatarList);
         avatarList = null;
         LogicUtils.disposeDisplayCollection(headList);
         headList = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

