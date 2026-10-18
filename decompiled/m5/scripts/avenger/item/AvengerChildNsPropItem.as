package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerChildNsInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerChildNsPropItem extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _propIcon:ScaleFrameImage;
      
      private var _addBtn:BaseButton;
      
      private var _gradeText:FilterFrameText;
      
      private var index:int;
      
      private var type:int;
      
      private var _data:AvengerChildNsInfo;
      
      public function AvengerChildNsPropItem(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsPropItem.back");
         _propIcon = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsPropItem.propIcon");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsPropItem.addBtn");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsPropItem.gradeText");
         addChild(_back);
         addChild(_propIcon);
         addChild(_addBtn);
         addChild(_gradeText);
         _back.setFrame(1);
         _propIcon.setFrame(index);
         _addBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",__addPropHandler);
      }
      
      private function removeEvent() : void
      {
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addPropHandler);
         }
      }
      
      private function __addPropHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         SoundManager.instance.play("022");
         if(getTypeGrade() >= tempMaxGrade)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ProficiencyFrame.maxText.text"));
            return;
         }
         AvengerManager.instance.sendChildNsPropUpgrade(data.childId,index);
      }
      
      public function get data() : AvengerChildNsInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerChildNsInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _data = param1;
         if(data)
         {
            _back.setFrame(data.profileGrade + 1);
            _back.y = data.profileGrade < 2 ? 30 : 24;
            _addBtn.visible = type == 1 && data.point > 0;
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",getTypeGrade());
            _loc2_ = GoodsHelp.getGoodColorString(data.profileGrade + 1);
            _loc3_ = getAddValue();
            this.tipData = LanguageMgr.GetTranslation("AvengerChildNsPropItem.propIcon.addValue" + index,_loc3_);
         }
         else
         {
            _addBtn.visible = false;
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",0);
            _loc2_ = GoodsHelp.getGoodColorString(1);
            _loc3_ = 0;
            this.tipData = null;
         }
      }
      
      private function getAddValue() : int
      {
         if(index == 1)
         {
            return data.addLive;
         }
         if(index == 2)
         {
            return data.addDefence;
         }
         if(index == 3)
         {
            return data.addAttack;
         }
         return 0;
      }
      
      private function getTypeGrade() : int
      {
         if(!data)
         {
            return 0;
         }
         var _loc1_:Array = [data.liveGrade,data.defenseGrade,data.attackGrade];
         return _loc1_[index - 1];
      }
      
      public function get tempMaxGrade() : int
      {
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(data.stageGrade,157);
         if(!_loc1_)
         {
            return 0;
         }
         return int(_loc1_.TemplateName.split(",")[0]);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_propIcon);
         _propIcon = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         super.dispose();
      }
   }
}

