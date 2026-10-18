package avenger
{
   import avatar.view.ShowAvatar;
   import avenger.item.AvengerSkillItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import mvc.module.avenger.AvengerModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.AvengerManager;
   import yishi.utils.NumberViewUtils;
   
   public class AvengerOtherFrame extends Frame
   {
      
      public var skillList:Vector.<AvengerSkillItem>;
      
      private var _back:MutipleImage;
      
      private var _heroAvatar:ShowAvatar;
      
      private var _skillCon:Component;
      
      private var skillLen:int = 6;
      
      private var selectIndex:int = 1;
      
      private var model:AvengerModel;
      
      private var thane:ThaneInfo;
      
      private var _liveValueText:FilterFrameText;
      
      private var _magicDefenceValueText:FilterFrameText;
      
      private var _defenceValue:FilterFrameText;
      
      private var _attackValueText:FilterFrameText;
      
      private var _numBit:BitmapData;
      
      private var _gradeCon1:Component;
      
      private var _gradeCon2:Component;
      
      private var _lv2:Image;
      
      private var _step1:Image;
      
      public function AvengerOtherFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.avenger.seeOtherBack");
         _skillCon = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.skillCon");
         _attackValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.other.proTxt1");
         _defenceValue = ComponentFactory.Instance.creatComponentByStylename("Avenger.other.proTxt2");
         _liveValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.other.proTxt3");
         _magicDefenceValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.other.proTxt4");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _gradeCon1 = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.other.gradeCon1");
         _gradeCon2 = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.other.gradeCon2");
         _lv2 = ComponentFactory.Instance.creatComponentByStylename("ui.avenger.otherLv");
         _step1 = ComponentFactory.Instance.creatComponentByStylename("ui.avenger.otherStep");
         addToContent(_back);
         initAvater();
         addToContent(_skillCon);
         addToContent(_attackValueText);
         addToContent(_defenceValue);
         addToContent(_liveValueText);
         addToContent(_magicDefenceValueText);
         addToContent(_step1);
         addToContent(_gradeCon1);
         addToContent(_lv2);
         addToContent(_gradeCon2);
         initSkillView();
      }
      
      private function initAvater() : void
      {
         _heroAvatar = new ShowAvatar(true);
         _heroAvatar.x = 50;
         _heroAvatar.y = 75;
         _heroAvatar.mouseChildren = _heroAvatar.mouseEnabled = false;
         addToContent(_heroAvatar);
      }
      
      private function initSkillView() : void
      {
         var _loc4_:AvengerSkillItem = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         skillList = new Vector.<AvengerSkillItem>();
         _loc3_ = 0;
         while(_loc3_ < skillLen)
         {
            _loc1_ = _loc3_ < 3 ? 1 : 2;
            _loc4_ = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillView.skillItem",[_loc1_,_loc3_ + 1,false]);
            _loc4_.x = int(_loc3_ / 3) <= 0 ? 15 : 285;
            _loc4_.y = int(_loc3_ % 3) * 100 + 80;
            _skillCon.addChild(_loc4_);
            skillList.push(_loc4_);
            _loc4_.selected = _loc3_ + 1 == selectIndex ? true : false;
            _loc3_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc5_:AvengerSkillItem = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(model == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < skillLen)
         {
            _loc5_ = skillList[_loc4_];
            _loc5_.data = _loc4_ < model.showSkillList.length ? model.showSkillList[_loc4_] : null;
            _loc5_.selected = false;
            _loc4_++;
         }
         var _loc3_:Array = model.avengerBodyPropAry;
         _attackValueText.text = _loc3_[0] + "";
         _defenceValue.text = _loc3_[1] + "";
         _magicDefenceValueText.text = _loc3_[2] + "";
         _liveValueText.text = _loc3_[3] + "";
         if(model.bodyInfo)
         {
            NumberViewUtils.refreshValue(model.bodyInfo.tempInfo.BodyType,_gradeCon1,_numBit,14,18,11,14,"0123456789");
         }
         var _loc1_:int = int(thane.isHoly ? 30 : thane.vocationGrades);
         NumberViewUtils.refreshValue(_loc1_,_gradeCon2,_numBit,14,18,11,14,"0123456789");
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         thane = param1;
         if(thane)
         {
            if(thane.avengerInfo)
            {
               model = thane.avengerInfo;
            }
            else
            {
               model = AvengerManager.instance.model;
            }
            _heroAvatar.data = thane;
            refreshView();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_heroAvatar);
         _heroAvatar = null;
         ObjectUtils.disposeObject(_skillCon);
         _skillCon = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         ObjectUtils.disposeObject(_liveValueText);
         _liveValueText = null;
         ObjectUtils.disposeObject(_magicDefenceValueText);
         _magicDefenceValueText = null;
         ObjectUtils.disposeObject(_defenceValue);
         _defenceValue = null;
         ObjectUtils.disposeObject(_attackValueText);
         _attackValueText = null;
         ObjectUtils.disposeObject(_gradeCon1);
         _gradeCon1 = null;
         ObjectUtils.disposeObject(_gradeCon2);
         _gradeCon2 = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_lv2);
         _lv2 = null;
         ObjectUtils.disposeObject(_step1);
         _step1 = null;
         super.dispose();
         model = null;
         thane = null;
      }
   }
}

