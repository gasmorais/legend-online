package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildGrowthBufferTips extends BaseTip
   {
      
      private var curText:FilterFrameText;
      
      private var nextText:FilterFrameText;
      
      private var curVbox:VBox;
      
      private var nextVbox:VBox;
      
      public function ChildGrowthBufferTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         curText = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.curText");
         nextText = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.nextText");
         curVbox = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.curVbox");
         nextVbox = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.nextVbox");
         addChild(curText);
         addChild(curVbox);
         addChild(nextText);
         addChild(nextVbox);
         curText.text = LanguageMgr.GetTranslation("ChildGrowthBufferTips.titleText.text");
         nextText.text = LanguageMgr.GetTranslation("ChildGrowthBufferTips.nextText.text");
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         var _loc7_:Array = null;
         var _loc4_:Array = null;
         var _loc10_:UpgradeTemplateInfo = null;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc8_:int = 0;
         var _loc2_:BufferTemplateInfo = null;
         var _loc9_:FilterFrameText = null;
         var _loc11_:int = 0;
         var _loc3_:BufferTemplateInfo = null;
         var _loc6_:FilterFrameText = null;
         curVbox.removeAllChild();
         nextVbox.removeAllChild();
         if(_data)
         {
            curText.text = LanguageMgr.GetTranslation("ChildGrowthBufferTips.titleText.text");
            _loc1_ = (_data as int) - 1;
            _loc7_ = [];
            _loc4_ = [];
            _loc10_ = TempleteManager.instance.getTemplateByLevelAndType(_loc1_,120);
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,120);
            if(_loc5_)
            {
               _loc4_ = _loc5_.TemplateName.split(",");
               if(!_loc10_)
               {
                  curText.text = LanguageMgr.GetTranslation("ChildGrowthBufferTips.titleText.text") + LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
               else
               {
                  _loc7_ = _loc10_.TemplateName.split(",");
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_.length)
                  {
                     _loc2_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(int(_loc7_[_loc8_]));
                     if(_loc2_)
                     {
                        _loc9_ = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.bufferText");
                        _loc9_.text = _loc2_.BufferName;
                        curVbox.addChild(_loc9_);
                     }
                     _loc8_++;
                  }
               }
               _loc11_ = 0;
               while(_loc11_ < _loc4_.length)
               {
                  _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(int(_loc4_[_loc11_]));
                  if(_loc3_)
                  {
                     _loc6_ = ComponentFactory.Instance.creatComponentByStylename("ChildCallTips.bufferText");
                     _loc6_.text = _loc3_.BufferName;
                     nextVbox.addChild(_loc6_);
                  }
                  _loc11_++;
               }
               curVbox.commitChanges();
               nextVbox.commitChanges();
               curVbox.y = curText.y + 20;
               nextText.y = curVbox.y + curVbox.height + 5;
               nextVbox.y = nextText.y + 20;
               _bg.height = curVbox.height + nextVbox.height + 60;
            }
            else
            {
               nextText.text = "";
               _bg.height = curVbox.height + 40;
            }
         }
         _bg.width = Math.max(320,curText.x + curText.textWidth + 10,nextText.x + nextText.textWidth + 10,nextVbox.x + nextVbox.width + 10,curVbox.x + curVbox.width + 10);
      }
      
      private function sortByKeyValue(param1:String, param2:String) : int
      {
         var _loc3_:int = int(param1);
         var _loc4_:int = int(param2);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 1;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(curText);
         curText = null;
         ObjectUtils.disposeObject(nextText);
         nextText = null;
         ObjectUtils.disposeObject(nextVbox);
         nextVbox = null;
         ObjectUtils.disposeObject(curVbox);
         curVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

