package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaHeroSkillItem extends DreamArenaCommonRightItem
   {
      
      private var _skillImage:ScaleFrameImage;
      
      private var _skillHbox:HBox;
      
      private var index:int;
      
      private var job:int;
      
      public function DreamArenaHeroSkillItem(param1:int)
      {
         index = param1;
         super();
         initItemView();
      }
      
      private function initItemView() : void
      {
         _skillImage = ComponentFactory.Instance.creatComponentByStylename("DreamArenaHeroSkillItem.skillImage");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaHeroSkillItem.skillHbox");
         addChild(_skillImage);
         addChild(_skillHbox);
         _skillImage.setFrame(1);
      }
      
      public function setJobType(param1:int) : void
      {
         var _loc2_:BaseIconView = null;
         var _loc8_:SkillTempInfo = null;
         var _loc9_:Bitmap = null;
         var _loc4_:Component = null;
         var _loc6_:int = 0;
         job = param1;
         _skillImage.setFrame(job + (index - 1) * 4);
         _skillHbox.removeAllChild();
         var _loc7_:int = int(job == 4 ? 0 : job);
         var _loc5_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,_loc7_);
         var _loc3_:Array = [];
         if(_loc5_)
         {
            _loc3_ = _loc5_["Skill" + index].split(",");
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc8_ = TempleteManager.instance.skillTemplateDic[_loc3_[_loc6_]];
            if(_loc8_ != null)
            {
               _loc4_ = new Component();
               _loc9_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaHeroSkillItem.skillBack");
               _loc2_ = ComponentFactory.Instance.creatCustomObject("DreamArenaHeroSkillItem.skillIcon");
               _loc4_.addChild(_loc9_);
               _loc4_.addChild(_loc2_);
               _loc2_.icon = IconFactory.getTecIconByIcon(_loc8_.Icons);
               _loc2_.tipData = _loc8_;
               _skillHbox.addChild(_loc4_);
            }
            _loc6_++;
         }
         refreshSelectState();
      }
      
      private function refreshSelectState() : void
      {
         if(model.selectJob == selfInfo.selfSelectJob && selfInfo.skillIndex1 == index)
         {
            refreshSelect(true);
            _skillImage.filters = [];
            _skillHbox.filters = [];
         }
         else
         {
            refreshSelect(false);
            _skillImage.filters = [UIFilter.getGrayFilter()];
            _skillHbox.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      public function refreshClientSelect() : void
      {
         if(model.clientSelectDic[22] && model.clientSelectDic[22] == index)
         {
            refreshSelect(true);
            _skillImage.filters = [];
            _skillHbox.filters = [];
         }
         else
         {
            refreshSelect(false);
            _skillImage.filters = [UIFilter.getGrayFilter()];
            _skillHbox.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      override protected function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         model.clientSelectDic.add(22,index);
         var _loc2_:int = 22;
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
      
      private function get selfInfo() : DreamArenaSelectRoleInfo
      {
         return model.selfInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillImage);
         _skillImage = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         super.dispose();
      }
   }
}

