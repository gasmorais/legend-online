package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.chess.SelfChessManager;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class SelfChessKindItem extends Component
   {
      
      public var _kindBg:Bitmap;
      
      public var _kindName:FilterFrameText;
      
      public var _kindNum:FilterFrameText;
      
      private var _kindIcon:BaseIconView;
      
      private var _job:int = 0;
      
      public function SelfChessKindItem()
      {
         super();
         initView();
      }
      
      public function set job(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:SelfChessBuffTempInfo = null;
         this.visible = param1 != 0;
         if(param1 == 0)
         {
            return;
         }
         if(_job == param1)
         {
            _kindNum.text = "" + SelfChessManager.Ins.model.getJobNum(_job);
         }
         else
         {
            _job = param1;
            _loc2_ = TempleteManager.instance.selfChessBuffTempCate.getTempJobList(_job);
            _loc3_ = _loc2_[0];
            _loc2_.sortOn("Amount",0x10 | 2);
            if(_loc2_)
            {
               _kindName.text = "" + _loc3_.TemplateName;
               _kindNum.text = "" + SelfChessManager.Ins.model.getJobNum(_job);
               _kindIcon.icon = PathManager.getSelfChessKindIcon(true,_job);
               tipData = _loc2_;
            }
         }
      }
      
      private function initView() : void
      {
         _kindBg = ComponentFactory.Instance.creatBitmap("asset.selfchess.kindBg");
         _kindName = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.kindName");
         _kindNum = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.kindNum");
         _kindIcon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.kindBigIcon");
         addChild(_kindBg);
         addChild(_kindName);
         addChild(_kindNum);
         addChild(_kindIcon);
         visible = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_kindBg);
         _kindBg = null;
         ObjectUtils.disposeObject(_kindName);
         _kindName = null;
         ObjectUtils.disposeObject(_kindNum);
         _kindNum = null;
         ObjectUtils.disposeObject(_kindIcon);
         _kindIcon = null;
         super.dispose();
      }
   }
}

