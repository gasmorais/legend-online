package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class MazeFloorTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _totalVBox:VBox;
      
      public function MazeFloorTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 240;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.MazeFloorTipTitleText");
         _title.text = LanguageMgr.GetTranslation("yishi.view.tips.MazeFloorTips.title");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("tips.StarsTotalBox");
         _totalVBox.width = _bg.width;
         _totalVBox.y = _title.y + _title.height + 5;
         addChild(_title);
         addChild(_totalVBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:Array = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc1_:FilterFrameText = null;
         if(tipData)
         {
            clean();
            _loc3_ = tipData as Array;
            for each(var _loc2_:String in _loc3_)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc2_));
               if(_loc4_)
               {
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.MazeFloorTipGoodText");
                  _loc1_.text = _loc4_.TemplateName;
                  _loc1_.setFrame(_loc4_.Profile);
                  _totalVBox.addChild(_loc1_);
               }
            }
            _bg.height = _totalVBox.y + _totalVBox.height + 10;
            _bg.width = _totalVBox.x + _totalVBox.width + 10;
         }
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_totalVBox.numChildren > 0)
         {
            _loc1_ = _totalVBox.getChildAt(0);
            _totalVBox.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_totalVBox)
         {
            ObjectUtils.disposeObject(_totalVBox);
         }
         _totalVBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

