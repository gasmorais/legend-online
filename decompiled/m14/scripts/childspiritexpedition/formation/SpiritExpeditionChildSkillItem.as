package childspiritexpedition.formation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.module.childspiritexpedition.SpiritExpeditionChildInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class SpiritExpeditionChildSkillItem extends Component
   {
      
      private var _itemBg:MutipleImage;
      
      private var _childIcon:BaseIconView;
      
      private var _skillBox:HBox;
      
      private var _delBtn:BaseButton;
      
      private var conList:Vector.<Component>;
      
      private var skillList:Vector.<BaseIconView>;
      
      private var skillDelList:Vector.<BaseButton>;
      
      private var _data:SpiritExpeditionChildInfo;
      
      private var curIndex:int = -1;
      
      private var _selectView:SpiritExpeditionSkillSelectView;
      
      public function SpiritExpeditionChildSkillItem()
      {
         super();
         initView();
         initSkillBox();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChildSkillItem.itemBg");
         _childIcon = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionChildSkillItem.childIcon");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChildSkillItem.skillBox");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChildSkillItem.delBtn");
         addChild(_itemBg);
         addChild(_childIcon);
         addChild(_delBtn);
         addChild(_skillBox);
         _delBtn.visible = false;
      }
      
      private function initSkillBox() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Component = null;
         var _loc5_:Bitmap = null;
         var _loc2_:BaseIconView = null;
         var _loc3_:BaseButton = null;
         conList = new Vector.<Component>();
         skillList = new Vector.<BaseIconView>();
         skillDelList = new Vector.<BaseButton>();
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc1_ = new Component();
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionChildSkillItem.skillBg");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionChildSkillItem.skillIcon");
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChildSkillItem.skillDelBtn");
            _loc1_.addChild(_loc5_);
            _loc1_.addChild(_loc2_);
            _loc1_.addChild(_loc3_);
            _skillBox.addChild(_loc1_);
            skillList.push(_loc2_);
            conList.push(_loc1_);
            skillDelList.push(_loc3_);
            _loc3_.visible = false;
            _loc1_.addEventListener("click",__selectSkillHandler);
            _loc3_.addEventListener("click",__delSkillHandler);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _delBtn.addEventListener("click",__delBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_delBtn)
         {
            _delBtn.removeEventListener("click",__delBtnClickHandler);
         }
      }
      
      private function __delSkillHandler(param1:MouseEvent) : void
      {
         var _loc5_:Array = null;
         var _loc2_:Component = param1.currentTarget as BaseButton;
         var _loc3_:int = skillDelList.indexOf(_loc2_);
         if(StringHelper.isNullOrEmpty(data.skills))
         {
            _loc5_ = [-1,-1,-1,-1,-1];
         }
         else
         {
            _loc5_ = data.skills.split(",");
         }
         _loc5_[_loc3_] = -1;
         var _loc4_:String = _loc5_.join(",");
         SpiritExpeditionManager.instance.sendExpeditionEditSkills(data.childId,_loc4_);
      }
      
      private function __selectSkillHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         if(!data)
         {
            return;
         }
         var _loc2_:Component = param1.currentTarget as Component;
         curIndex = conList.indexOf(_loc2_);
         var _loc4_:Array = getShowAryByIndex(curIndex);
         if(_loc4_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("spiritExpedition.childSkill.noSelectAlert"));
            return;
         }
         if(!_selectView)
         {
            _selectView = new SpiritExpeditionSkillSelectView();
            _selectView.show(_loc4_,selectSkillBack);
            _selectView.addEventListener("dispose",__disposeSelectView);
            _loc3_ = new Point(_loc2_.displayWidth / 2,0);
            _loc3_ = this.localToGlobal(_loc3_);
            _selectView.x = _loc3_.x + _loc2_.x - 30;
            _selectView.y = _loc3_.y - 100;
         }
      }
      
      private function selectSkillBack(param1:SkillTempInfo) : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         if(!param1)
         {
            return;
         }
         if(StringHelper.isNullOrEmpty(data.skills))
         {
            _loc4_ = [-1,-1,-1,-1,-1];
         }
         else
         {
            _loc4_ = data.skills.split(",");
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc4_[_loc2_] == param1.SonType)
            {
               if(_loc4_[curIndex])
               {
                  _loc4_[_loc2_] = _loc4_[curIndex];
               }
               else
               {
                  _loc4_[_loc2_] = -1;
               }
            }
            _loc2_++;
         }
         _loc4_[curIndex] = param1.SonType;
         var _loc3_:String = _loc4_.join(",");
         SpiritExpeditionManager.instance.sendExpeditionEditSkills(data.childId,_loc3_);
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         _selectView.removeEventListener("dispose",__disposeSelectView);
         _selectView = null;
         curIndex = -1;
      }
      
      private function __delBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:String = "";
         for each(var _loc3_:SpiritExpeditionChildInfo in model.enterWarList)
         {
            if(_loc3_.pos > 0)
            {
               if(_loc3_.childId != data.childId)
               {
                  _loc2_ += _loc3_.childId + "," + _loc3_.pos + "|";
               }
            }
         }
         _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf("|"));
         SpiritExpeditionManager.instance.sendExpeditionEditFormation(_loc2_);
      }
      
      public function get data() : SpiritExpeditionChildInfo
      {
         return _data;
      }
      
      public function set data(param1:SpiritExpeditionChildInfo) : void
      {
         var _loc7_:int = 0;
         var _loc4_:BaseIconView = null;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc9_:SkillTempInfo = null;
         var _loc8_:int = 0;
         _data = param1;
         if(!data)
         {
            _delBtn.visible = false;
            _childIcon.icon = null;
            _childIcon.tipData = null;
            for each(var _loc6_:BaseIconView in skillList)
            {
               _loc6_.icon = null;
               _loc6_.tipData = null;
            }
            for each(var _loc10_:BaseButton in skillDelList)
            {
               _loc10_.visible = false;
            }
            return;
         }
         _delBtn.visible = true;
         if(data.childData)
         {
            _childIcon.icon = PathManager.info.ResourcePath + "icon" + data.childData.childTempInfo.Icon;
            _childIcon.tipData = data.childData;
         }
         var _loc5_:Array = data.skills.split(",");
         _loc7_ = 0;
         while(_loc7_ < skillList.length)
         {
            _loc4_ = skillList[_loc7_];
            _loc2_ = int(_loc5_[_loc7_]);
            if(_loc2_ == -1)
            {
               _loc4_.icon = null;
               _loc4_.tipData = null;
               skillDelList[_loc7_].visible = false;
            }
            else
            {
               _loc3_ = data.childData.skill.split(",");
               _loc8_ = 0;
               while(_loc8_ < _loc3_.length)
               {
                  if(_loc3_[_loc8_] && parseInt(_loc3_[_loc8_]) > 0)
                  {
                     if(TempleteManager.instance.getSkillById(_loc3_[_loc8_]).SonType == _loc2_)
                     {
                        _loc9_ = TempleteManager.instance.getSkillById(_loc3_[_loc8_]);
                     }
                  }
                  _loc8_++;
               }
               if(_loc9_)
               {
                  _loc4_.icon = IconFactory.getTecIconByIcon(_loc9_.Icons);
                  _loc4_.tipData = _loc9_;
                  skillDelList[_loc7_].visible = true;
               }
            }
            _loc7_++;
         }
      }
      
      private function getShowAryByIndex(param1:int) : Array
      {
         var _loc6_:SkillTempInfo = null;
         var _loc5_:int = 0;
         var _loc4_:int = int(data.skills.split(",")[param1]);
         var _loc3_:Array = data.childData.skill.split(",");
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_] && parseInt(_loc3_[_loc5_]) > 0)
            {
               _loc6_ = TempleteManager.instance.getSkillById(_loc3_[_loc5_]);
               if(_loc6_)
               {
                  if(_loc4_ != _loc6_.SonType)
                  {
                     if(_loc6_.UseWay == 1)
                     {
                        _loc2_.push(_loc6_);
                     }
                  }
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function removeSkillEvent(param1:DisplayObject) : void
      {
         if(param1)
         {
            param1.removeEventListener("click",__selectSkillHandler);
         }
      }
      
      private function removeSkillDelEvent(param1:DisplayObject) : void
      {
         if(param1)
         {
            param1.removeEventListener("click",__delSkillHandler);
         }
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_childIcon);
         _childIcon = null;
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
         LogicUtils.disposeDisplayCollection(conList,removeSkillEvent);
         conList = null;
         LogicUtils.disposeDisplayCollection(skillDelList,removeSkillDelEvent);
         skillDelList = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

