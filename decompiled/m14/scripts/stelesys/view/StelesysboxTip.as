package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.stele.StelaAttInfo;
   import mvc.module.stele.StelesysInfo;
   import stelesys.item.StelaSkillItem;
   import stelesys.item.StelesysBoxItem;
   import stelesys.item.StelesysNameAndValueTxt;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class StelesysboxTip extends BaseTip
   {
      
      private var _contentSp:VBox;
      
      private var _box:StelesysBoxItem;
      
      private var _nameTxt:FilterFrameText;
      
      private var _line1:Image;
      
      private var _attBox:VBox;
      
      private var _boxList:Array = [];
      
      private var _skillItem:StelaSkillItem;
      
      private var _line2:Image;
      
      private var _refineBox:VBox;
      
      private var _refineList:Array = [];
      
      public function StelesysboxTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:StelesysNameAndValueTxt = null;
         var _loc2_:int = 0;
         var _loc3_:FilterFrameText = null;
         super.init();
         _bg.width = 230;
         _contentSp = new VBox();
         _contentSp.y = 25;
         _contentSp.spacing = 10;
         _box = ComponentFactory.Instance.creatCustomObject("ui.stela.tip.itemBox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.tip.stelaNameTxt");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("ui.stela.tip.line1");
         _attBox = ComponentFactory.Instance.creatCustomObject("ui.stela.tip.attvBox1");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("ui.stela.tip.line2");
         _skillItem = ComponentFactory.Instance.creatCustomObject("ui.stela.tip.skillItem");
         _refineBox = ComponentFactory.Instance.creatCustomObject("ui.stela.tip.refinevbox");
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new StelesysNameAndValueTxt("ui.stelesys.attNameTxt","ui.stelesys.attValueTxt");
            _boxList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineMItemTxt");
            _refineList[_loc2_] = _loc3_;
            _loc2_++;
         }
         addChild(_contentSp);
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:StelaAttInfo = null;
         var _loc3_:StelesysNameAndValueTxt = null;
         var _loc1_:Array = null;
         var _loc9_:String = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:FilterFrameText = null;
         var _loc8_:Array = null;
         var _loc4_:SkillTempInfo = null;
         var _loc10_:StelesysInfo = _data as StelesysInfo;
         if(_loc10_)
         {
            _contentSp.beginChanges();
            ObjectUtils.removeChildAllChildrenFromStage(_contentSp);
            ObjectUtils.removeChildAllChildrenFromStage(_attBox);
            _box.data = _loc10_;
            _nameTxt.htmlText = _loc10_.nameStep;
            _loc6_ = _loc10_.stelaAttInfo;
            _loc1_ = _loc6_.hasValueAtt;
            _loc5_ = 0;
            _attBox.beginChanges();
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc9_ = _loc1_[_loc5_];
               _loc3_ = _boxList[_loc5_];
               _loc3_.nameTxt = _loc9_;
               _loc3_.valueTxt = _loc6_[_loc9_];
               _attBox.addChild(_loc3_);
               _loc5_++;
            }
            _attBox.commitChanges();
            _skillItem.refreshView(_loc10_);
            _contentSp.addChild(_box);
            _contentSp.addChild(_nameTxt);
            _contentSp.addChild(_line1);
            _contentSp.addChild(_attBox);
            _contentSp.addChild(_skillItem);
            _refineBox.beginChanges();
            _refineBox.removeAllChild();
            _loc8_ = [_loc10_.skill1,_loc10_.skill2,_loc10_.skill3,_loc10_.skill4,_loc10_.skill5];
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               _loc2_ = int(_loc8_[_loc5_]);
               _loc7_ = _refineList[_loc5_];
               if(_loc2_ > 0)
               {
                  _refineBox.addChild(_loc7_);
                  _loc4_ = TempleteManager.instance.getSkillById(_loc2_);
                  if(_loc4_)
                  {
                     _loc7_.text = _loc4_.TemplateName;
                  }
               }
               _loc5_++;
            }
            _refineBox.commitChanges();
            if(_refineBox.numChildren > 0)
            {
               _contentSp.addChild(_line2);
               _contentSp.addChild(_refineBox);
            }
            _contentSp.commitChanges();
            _bg.height = _contentSp.y + _contentSp.height + 5;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_box);
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_attBox);
         _attBox = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         ObjectUtils.disposeObject(_refineBox);
         _refineBox = null;
         ObjectUtils.disposeObject(_skillItem);
         _skillItem = null;
         ObjectUtils.disposeObject(_contentSp);
         _contentSp = null;
         super.dispose();
         _refineList = null;
      }
   }
}

