package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ChildNursingSpiritItem extends Component
   {
      
      private var back:Bitmap;
      
      private var selectBg:Bitmap;
      
      private var childIcon:BaseIconView;
      
      private var masteIcon:Image;
      
      private var slavedIcon:Image;
      
      private var nameText:FilterFrameText;
      
      private var gradeText:FilterFrameText;
      
      private var fightText:FilterFrameText;
      
      private var _tempInfo:ChildTempInfo;
      
      private var _childData:ChildData;
      
      public function ChildNursingSpiritItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.ChildNursingSpiritItem.back");
         selectBg = ComponentFactory.Instance.creatBitmap("asset.ChildNursingSpiritItem.selectBg");
         childIcon = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritItem.childIcon");
         masteIcon = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.masteIcon");
         slavedIcon = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.slavedIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.nameText");
         gradeText = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.gradeText");
         fightText = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.fightText");
         addChild(back);
         addChild(selectBg);
         addChild(childIcon);
         addChild(masteIcon);
         addChild(slavedIcon);
         addChild(nameText);
         addChild(gradeText);
         addChild(fightText);
         selectBg.visible = false;
         masteIcon.visible = false;
         slavedIcon.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_LIFEWHEEL_BTNENABLE",this,__itemeEnableChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_LIFEWHEEL_BTNENABLE",this,__itemeEnableChange);
      }
      
      private function __itemeEnableChange(param1:String, param2:Object) : void
      {
         var _loc3_:Boolean = param2 as Boolean;
         this.mouseChildren = this.mouseEnabled = _loc3_;
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!tempInfo)
         {
            return;
         }
         nsModel.selectedNsChild = nsModel.getNsChildDataByJob(tempInfo.JobType);
         nsModel.selectedNsChildTemp = tempInfo;
      }
      
      public function get tempInfo() : ChildTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ChildTempInfo) : void
      {
         _tempInfo = param1;
         masteIcon.visible = false;
         slavedIcon.visible = false;
         gradeText.text = "";
         fightText.text = "";
         nameText.text = "";
         this.buttonMode = false;
         this.filters = [UIFilter.getGrayFilter()];
         if(_tempInfo)
         {
            nameText.text = _tempInfo.JobName;
            this.buttonMode = true;
            _childData = nsModel.getNsChildDataByJob(_tempInfo.JobType);
            childIcon.icon = PathManager.info.ResourcePath + "icon" + _tempInfo.Icon;
            if(_childData)
            {
               this.filters = [];
               if(_childData.fightUserId == playerModel.playerInfo.userId)
               {
                  masteIcon.visible = true;
                  slavedIcon.visible = false;
               }
               else if(_childData.fightSlaveUserId == playerModel.playerInfo.userId)
               {
                  masteIcon.visible = false;
                  slavedIcon.visible = true;
               }
               if(_childData.nursingSpiritInfo.trainInfo.clientFlg == 1)
               {
                  nameText.setFrame(2);
                  gradeText.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.gradeText.text2",_childData.nursingSpiritInfo.trainInfo.grade);
               }
               else
               {
                  nameText.setFrame(1);
                  gradeText.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.gradeText.text",_childData.growthGrade);
               }
               fightText.htmlText = LanguageMgr.GetTranslation("ChildNursingSpiritItem.fightText.text",_childData.fightValue);
            }
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(!tempInfo)
         {
            return;
         }
         selectBg.visible = param1;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(selectBg);
         selectBg = null;
         ObjectUtils.disposeObject(childIcon);
         childIcon = null;
         ObjectUtils.disposeObject(masteIcon);
         masteIcon = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(gradeText);
         gradeText = null;
         ObjectUtils.disposeObject(fightText);
         fightText = null;
         ObjectUtils.disposeObject(slavedIcon);
         slavedIcon = null;
         super.dispose();
      }
   }
}

