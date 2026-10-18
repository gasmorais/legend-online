package child.nursingspirit
{
   import child.attribute.ChildShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildComposeTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSComposeView extends Component
   {
      
      private var backMc:MovieClip;
      
      private var mainSelectBtn:BaseButton;
      
      private var slaveSelectBtn:BaseButton;
      
      private var mainChildIcon:BaseIconView;
      
      private var slaveChildIcon:BaseIconView;
      
      private var mainText:FilterFrameText;
      
      private var slaveText:FilterFrameText;
      
      private var newNsText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var newFigure:ChildShowAvatar;
      
      private var previewBtn:IconButton;
      
      private var materialHbox:HBox;
      
      private var helpImage:Image;
      
      private var composeBtn:IconButton;
      
      private var selectChildView:ChildComposeSelectView;
      
      private var mainChild:ChildData;
      
      private var slaveChild:ChildData;
      
      private var hasMaterial:Boolean = true;
      
      private var composeTempInfo:ChildComposeTempInfo;
      
      public function ChildNSComposeView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         backMc = ComponentFactory.Instance.creatCustomObject("ChildNSComposeView.backMc");
         mainSelectBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.mainSelectBtn");
         slaveSelectBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.slaveSelectBtn");
         descText = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.descText");
         helpImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.helpImage");
         materialHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.materialHbox");
         composeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.composeBtn");
         mainText = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.mainText");
         slaveText = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.slaveText");
         newNsText = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.newNsText");
         previewBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSComposeView.previewBtn");
         mainChildIcon = ComponentFactory.Instance.creatCustomObject("ChildNSComposeView.mainChildIcon");
         slaveChildIcon = ComponentFactory.Instance.creatCustomObject("ChildNSComposeView.slaveChildIcon");
         newFigure = new ChildShowAvatar();
         addChild(backMc);
         addChild(mainSelectBtn);
         addChild(slaveSelectBtn);
         addChild(mainText);
         addChild(slaveText);
         addChild(descText);
         addChild(helpImage);
         addChild(newFigure);
         newFigure.x = 270;
         newFigure.y = -10;
         addChild(newNsText);
         addChild(previewBtn);
         addChild(materialHbox);
         addChild(composeBtn);
         backMc.mouseChildren = backMc.mouseEnabled = false;
         newFigure.mouseChildren = newFigure.mouseEnabled = false;
         mainText.text = LanguageMgr.GetTranslation("ChildNSComposeView.mainText.text");
         slaveText.text = LanguageMgr.GetTranslation("ChildNSComposeView.slaveText.text");
      }
      
      private function addEvent() : void
      {
         mainSelectBtn.addEventListener("click",__slaveSelectChildHandler);
         mainChildIcon.addEventListener("click",__slaveSelectChildHandler);
         slaveSelectBtn.addEventListener("click",__slaveSelectChildHandler);
         slaveChildIcon.addEventListener("click",__slaveSelectChildHandler);
         composeBtn.addEventListener("click",__composeClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_COMPOSE_SELECT",this,__selectComposeChildHandle);
         previewBtn.addEventListener("click",__previewClickHandler);
      }
      
      private function removeEvent() : void
      {
         mainSelectBtn.removeEventListener("click",__slaveSelectChildHandler);
         mainChildIcon.removeEventListener("click",__slaveSelectChildHandler);
         slaveSelectBtn.removeEventListener("click",__slaveSelectChildHandler);
         slaveChildIcon.removeEventListener("click",__slaveSelectChildHandler);
         composeBtn.removeEventListener("click",__composeClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_COMPOSE_SELECT",this,__selectComposeChildHandle);
         previewBtn.removeEventListener("click",__previewClickHandler);
      }
      
      private function __selectComposeChildHandle(param1:String, param2:Object) : void
      {
         var _loc3_:ChildTempInfo = null;
         var _loc5_:int = int(param2.type);
         var _loc4_:ChildData = param2.data;
         if(!composeTempInfo || !_loc4_)
         {
            return;
         }
         if(_loc4_.growthGrade < composeTempInfo.NeedGrade)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSComposeView.noRightGrade.alert",composeTempInfo.NeedGrade));
            return;
         }
         if(_loc5_ == 1)
         {
            if(mainChildIcon && mainChildIcon.parent)
            {
               mainChildIcon.parent.removeChild(mainChildIcon);
            }
            mainChild = _loc4_;
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(mainChild.job,mainChild.growthGrade);
            if(_loc3_)
            {
               mainChildIcon.icon = PathManager.info.ResourcePath + "icon" + _loc3_.Icon;
               addChild(mainChildIcon);
               mainChildIcon.tipData = mainChild;
               mainChildIcon.buttonMode = true;
            }
            if(slaveChild && slaveChild.job == mainChild.job)
            {
               if(slaveChildIcon && slaveChildIcon.parent)
               {
                  slaveChildIcon.parent.removeChild(slaveChildIcon);
               }
               slaveChild = null;
            }
         }
         else
         {
            if(slaveChildIcon && slaveChildIcon.parent)
            {
               slaveChildIcon.parent.removeChild(slaveChildIcon);
            }
            slaveChild = _loc4_;
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(slaveChild.job,slaveChild.growthGrade);
            if(_loc3_)
            {
               slaveChildIcon.icon = PathManager.info.ResourcePath + "icon" + _loc3_.Icon;
               addChild(slaveChildIcon);
               slaveChildIcon.tipData = slaveChild;
               slaveChildIcon.buttonMode = true;
            }
            if(mainChild && mainChild.job == slaveChild.job)
            {
               if(mainChildIcon && mainChildIcon.parent)
               {
                  mainChildIcon.parent.removeChild(mainChildIcon);
               }
               mainChild = null;
            }
         }
      }
      
      private function __slaveSelectChildHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Point = null;
         if(param1.currentTarget == mainSelectBtn || param1.currentTarget == mainChildIcon)
         {
            _loc3_ = 1;
         }
         else if(param1.currentTarget == slaveSelectBtn || param1.currentTarget == slaveChildIcon)
         {
            _loc3_ = 2;
         }
         if(!composeTempInfo)
         {
            return;
         }
         if(!selectChildView)
         {
            selectChildView = new ChildComposeSelectView(_loc3_);
            selectChildView.show(childModel.getComposeChildListByNeedJob(composeTempInfo));
            selectChildView.addEventListener("dispose",__disposeSelectView);
            _loc2_ = new Point(mainSelectBtn.displayWidth / 2,0);
            _loc2_ = mainSelectBtn.localToGlobal(_loc2_);
            selectChildView.x = _loc2_.x + 45;
            selectChildView.y = _loc2_.y + 15;
         }
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         selectChildView.removeEventListener("dispose",__disposeSelectView);
         ObjectUtils.disposeObject(selectChildView);
         selectChildView = null;
      }
      
      private function __composeClickHandler(param1:MouseEvent) : void
      {
         if(!composeTempInfo)
         {
            return;
         }
         if(!mainChild || !slaveChild)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSComposeView.noSelectChild.alert"));
            return;
         }
         if(!hasMaterial)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSComposeView.noMaterial.alert"));
            return;
         }
         ChildSender.composeChild(composeTempInfo.JobType,mainChild.childId,slaveChild.childId);
      }
      
      private function __previewClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","PREVIEW_FRAME");
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         clean();
         if(!nsModel.selectedNsChildTemp)
         {
            return;
         }
         composeTempInfo = TempleteManager.instance.childComposeTemplateCate.getTemplateByJobType(nsModel.selectedNsChildTemp.JobType);
         if(!composeTempInfo)
         {
            return;
         }
         newFigure.data = figureData;
         helpImage.tipData = LanguageMgr.GetTranslation("ChildNSComposeView.helpImage.tipdata",composeTempInfo.NeedGrade);
         var _loc11_:Array = composeTempInfo.NeedJobType.split(",");
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc11_[0],1);
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc11_[1],1);
         descText.text = LanguageMgr.GetTranslation("ChildNSComposeView.descText.text",_loc2_.JobName,_loc4_.JobName,composeTempInfo.NeedGrade);
         newNsText.text = nsModel.selectedNsChildTemp.JobName;
         var _loc1_:Array = composeTempInfo.NeedMaterial.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = _loc1_[_loc5_];
            _loc6_ = int(_loc8_.split(",")[0]);
            _loc3_ = int(_loc8_.split(",")[1]);
            _loc9_ = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc6_));
            _loc10_ = ComponentFactory.Instance.creatCustomObject("ChildNSComposeView.baseItem");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc6_;
            _loc10_.data = _loc7_;
            _loc10_.setItemTextOther(_loc9_ + "/" + _loc3_);
            materialHbox.addChild(_loc10_);
            if(_loc9_ < _loc3_)
            {
               hasMaterial = false;
            }
            _loc5_++;
         }
      }
      
      private function get figureData() : ChildData
      {
         var _loc1_:ChildData = new ChildData();
         _loc1_.state = 1;
         _loc1_.job = nsModel.selectedNsChildTemp.JobType;
         _loc1_.growthGrade = nsModel.selectedNsChildTemp.Grades;
         return _loc1_;
      }
      
      private function clean() : void
      {
         if(isDie)
         {
            return;
         }
         mainChild = null;
         slaveChild = null;
         newFigure.data = null;
         descText.text = "";
         helpImage.tipData = "";
         newNsText.text = "";
         materialHbox.removeAllChild();
         if(mainChildIcon && mainChildIcon.parent)
         {
            mainChildIcon.parent.removeChild(mainChildIcon);
         }
         if(slaveChildIcon && slaveChildIcon.parent)
         {
            slaveChildIcon.parent.removeChild(slaveChildIcon);
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         mainChild = null;
         slaveChild = null;
         ObjectUtils.disposeViolentMc(backMc);
         backMc = null;
         ObjectUtils.disposeObject(mainSelectBtn);
         mainSelectBtn = null;
         ObjectUtils.disposeObject(slaveSelectBtn);
         slaveSelectBtn = null;
         ObjectUtils.disposeObject(descText);
         descText = null;
         ObjectUtils.disposeObject(helpImage);
         helpImage = null;
         ObjectUtils.disposeObject(materialHbox);
         materialHbox = null;
         ObjectUtils.disposeObject(composeBtn);
         composeBtn = null;
         ObjectUtils.disposeObject(mainChildIcon);
         mainChildIcon = null;
         ObjectUtils.disposeObject(slaveChildIcon);
         slaveChildIcon = null;
         ObjectUtils.disposeObject(newFigure);
         newFigure = null;
         ObjectUtils.disposeObject(mainText);
         mainText = null;
         ObjectUtils.disposeObject(slaveText);
         slaveText = null;
         ObjectUtils.disposeObject(newNsText);
         newNsText = null;
         ObjectUtils.disposeObject(previewBtn);
         previewBtn = null;
         ObjectUtils.disposeObject(selectChildView);
         selectChildView = null;
         super.dispose();
      }
   }
}

