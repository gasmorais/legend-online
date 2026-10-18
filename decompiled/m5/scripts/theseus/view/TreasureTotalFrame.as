package theseus.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   
   public class TreasureTotalFrame extends Frame
   {
      
      private static const SKILL:int = 3;
      
      private var _bg:Scale9CornerImage;
      
      private var _propertyVBox:VBox;
      
      private var _valueVBox:VBox;
      
      private var _skillList:Array = [];
      
      private var _line:Bitmap;
      
      private var _btn:IconButton;
      
      public function TreasureTotalFrame()
      {
         super();
         initView();
         refreshView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("TreasurePageView.allTxt.text");
         _bg = ComponentFactory.Instance.creatComponentByStylename("TreasureTotalFrame.bg");
         _propertyVBox = ComponentFactory.Instance.creatCustomObject("TreasureTotalFrame.propertyVBox");
         _valueVBox = ComponentFactory.Instance.creatCustomObject("TreasureTotalFrame.valueVBox");
         _line = ComponentFactory.Instance.creatBitmap("asset.theseus.treasureLine");
         _btn = ComponentFactory.Instance.creatComponentByStylename("TreasureTotalFrame.btn");
         addToContent(_bg);
         addToContent(_propertyVBox);
         addToContent(_valueVBox);
         addToContent(_line);
         addToContent(_btn);
         _line.x = 30;
         _line.y = 355;
         initSkillItem();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function initSkillItem() : void
      {
         var _loc1_:TreasureSkillItem = null;
         var _loc2_:int = 0;
         _skillList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.item",[_loc2_ + 1]);
            _loc1_.x = 200;
            _loc1_.y = 50 + _loc2_ * 100;
            addToContent(_loc1_);
            _skillList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         refreshVBox(model.treasurePros.attNames,model.treasurePros.attValues);
         refreshSkillItem();
      }
      
      private function refreshSkillItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:TreasureSkillItem = null;
         var _loc4_:SkillTempInfo = null;
         var _loc1_:Array = [];
         if(coreInfo && coreInfo.CoreSkills)
         {
            _loc1_ = coreInfo.CoreSkills.split(",");
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _skillList[_loc3_];
            if(_loc1_[_loc3_])
            {
               _loc4_ = TempleteManager.instance.skillTemplateDic[_loc1_[_loc3_]];
               _loc2_.data = _loc4_;
            }
            else
            {
               _loc2_.data = null;
            }
            _loc3_++;
         }
      }
      
      private function refreshVBox(param1:Array, param2:Array) : void
      {
         var _loc3_:FilterFrameText = null;
         _propertyVBox.removeAllChild();
         _valueVBox.removeAllChild();
         var _loc4_:int = 0;
         _propertyVBox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("TreasureTotalFrame.propertyTxt");
            _loc3_.text = "" + param1[_loc4_];
            _propertyVBox.addChild(_loc3_);
            _loc4_++;
         }
         _propertyVBox.commitChanges();
         _valueVBox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("TreasureTotalFrame.valueTxt");
            _loc3_.text = "+" + param2[_loc4_];
            _valueVBox.addChild(_loc3_);
            _loc4_++;
         }
         _valueVBox.commitChanges();
         _propertyVBox.y = (360 - _propertyVBox.height) / 2;
         _valueVBox.y = (360 - _valueVBox.height) / 2;
      }
      
      private function get coreInfo() : TheseusTreasureCoreInfo
      {
         return TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(model.coreLevel);
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
      
      private function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeAllChildren(_propertyVBox);
         _propertyVBox = null;
         ObjectUtils.disposeAllChildren(_valueVBox);
         _valueVBox = null;
         for each(var _loc1_:TreasureSkillItem in _skillList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

