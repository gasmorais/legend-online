package child.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ChildSkillListView extends Component
   {
      
      private var _skillBg:ScaleFrameImage;
      
      private var _skillBattleBg:Bitmap;
      
      private var _skillPanel:ScrollPanel;
      
      private var _skillVBox:VBox;
      
      private var _battleSkillHbox:HBox;
      
      private var _selectedIndex:int;
      
      private var _currSkillVct:Vector.<SkillTempInfo>;
      
      public function ChildSkillListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBg = ComponentFactory.Instance.creatComponentByStylename("childSkill.skillBg");
         _skillPanel = ComponentFactory.Instance.creatComponentByStylename("childSkill.ScrollPanel");
         _skillVBox = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.battleSkillVbox");
         _battleSkillHbox = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.battleSkillHbox");
         _skillBattleBg = ComponentFactory.Instance.creatBitmap("asset.childSkill.battleSkillImg");
         _skillBg.setFrame(1);
         addChild(_skillBg);
         _skillPanel.setView(_skillVBox);
         _skillPanel.invalidateViewport();
         addChild(_skillPanel);
         addChild(_skillBattleBg);
         addChild(_battleSkillHbox);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("REFRESHCHILDBATTLESKILL",__refreshChildBattleSkillHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         refreshSkill();
         refreshBattleSkill();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("REFRESHCHILDBATTLESKILL",__refreshChildBattleSkillHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function refreshSkill() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ChildSkillItem = null;
         ObjectUtils.disposeAllChildren(_skillVBox);
         var _loc3_:ChildData = ChildManager.instance.model.selectedChild;
         _currSkillVct = TempleteManager.instance.getAllChildSkillByJobAndUseWay(_loc3_.job,_selectedIndex + 1);
         _currSkillVct.sort(skillsSort);
         var _loc1_:int = int(_currSkillVct.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("child.skillItem");
            _loc4_.data = _currSkillVct[_loc2_];
            _skillVBox.addChild(_loc4_);
            _loc2_++;
         }
         _skillPanel.invalidateViewport();
      }
      
      private function skillsSort(param1:SkillTempInfo, param2:SkillTempInfo) : int
      {
         var _loc3_:int = 0;
         if(param1.MasterType == 44 && param2.MasterType != 44)
         {
            _loc3_ = 1;
         }
         else if(param1.MasterType != 44 && param2.MasterType == 44)
         {
            _loc3_ = -1;
         }
         else if(param1.TemplateId < param2.TemplateId)
         {
            _loc3_ = -1;
         }
         else if(param1.TemplateId > param2.TemplateId)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      private function refreshBattleSkill() : void
      {
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:ChildBattleSkillItemView = null;
         var _loc2_:Array = null;
         var _loc3_:SkillTempInfo = null;
         var _loc6_:int = 0;
         ObjectUtils.disposeAllChildren(_battleSkillHbox);
         var _loc5_:String = ChildManager.instance.model.selectedChild.fightSkill;
         if(_loc5_)
         {
            _loc1_ = _loc5_.split(",");
         }
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("child.ChildBattleSkillView",[1]);
            _battleSkillHbox.addChild(_loc7_);
            if(_loc1_ && _loc1_[_loc4_] && _loc1_[_loc4_] != "-1")
            {
               _loc2_ = ChildManager.instance.model.selectedChild.skill.split(",");
               _loc6_ = 0;
               while(_loc6_ < _loc2_.length)
               {
                  if(_loc2_[_loc6_] && parseInt(_loc2_[_loc6_]) > 0)
                  {
                     if(TempleteManager.instance.getSkillById(_loc2_[_loc6_]).SonType == _loc1_[_loc4_])
                     {
                        _loc3_ = TempleteManager.instance.getSkillById(_loc2_[_loc6_]);
                     }
                  }
                  _loc6_++;
               }
               _loc7_.data = _loc3_;
            }
            else
            {
               _loc7_.data = null;
            }
            _loc7_.index = _loc4_ + 1;
            _loc4_++;
         }
      }
      
      private function __refreshChildBattleSkillHandler(param1:NotificationEvent) : void
      {
         ChildSender.carrySkill(ChildManager.instance.model.selectedChild.childId,getCurrBattleSkillStr());
      }
      
      private function getCurrBattleSkillStr() : String
      {
         var _loc3_:int = 0;
         var _loc2_:ChildBattleSkillItemView = null;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = _battleSkillHbox.getChildAt(_loc3_) as ChildBattleSkillItemView;
            if(_loc2_.data)
            {
               if(_loc3_ == 4)
               {
                  _loc1_ += _loc2_.data.SonType;
               }
               else
               {
                  _loc1_ += _loc2_.data.SonType + ",";
               }
            }
            else if(_loc3_ == 4)
            {
               _loc1_ += "-1";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function set selected(param1:int) : void
      {
         _selectedIndex = param1;
         _skillBg.setFrame(_selectedIndex + 1);
         refreshSkill();
         refreshBattleSkill();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_skillBg)
         {
            ObjectUtils.disposeObject(_skillBg);
         }
         _skillBg = null;
         if(_skillBattleBg)
         {
            ObjectUtils.disposeObject(_skillBattleBg);
         }
         _skillBattleBg = null;
         if(_skillPanel)
         {
            ObjectUtils.disposeObject(_skillPanel);
         }
         _skillPanel = null;
         if(_skillVBox)
         {
            ObjectUtils.disposeObject(_skillVBox);
         }
         _skillVBox = null;
         if(_battleSkillHbox)
         {
            ObjectUtils.disposeObject(_battleSkillHbox);
         }
         _battleSkillHbox = null;
         _currSkillVct = null;
         super.dispose();
      }
   }
}

