package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class ChildSelectJobItem extends Component
   {
      
      private var _job:int = 0;
      
      private var _sex:int = -1;
      
      private var _selected:Boolean = false;
      
      private var _scaleBg:Scale9CornerImage;
      
      private var _bg:ScaleFrameImage;
      
      private var _body:ScaleFrameImage;
      
      private var _jobType:ScaleFrameImage;
      
      private var _movie:MovieClip;
      
      private var _topBg:Bitmap;
      
      public function ChildSelectJobItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("child.childSelectJob.selectBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("child.childSelectJob.jobBg");
         _body = ComponentFactory.Instance.creatComponentByStylename("child.childSelectJob.jobBody");
         _jobType = ComponentFactory.Instance.creatComponentByStylename("child.childSelectJob.jobType");
         _topBg = ComponentFactory.Instance.creatBitmap("asset.childSelectJob.border");
         addChild(_bg);
         addChild(_body);
         addChild(_topBg);
         addChild(_scaleBg);
         _scaleBg.visible = false;
         this.buttonMode = true;
      }
      
      private function initEvent() : void
      {
      }
      
      private function creatEff() : void
      {
         if(job > 0)
         {
            _movie = ComponentFactory.Instance.creat("asset.childSelectJob.job" + job);
            _movie.mouseChildren = _movie.mouseEnabled = false;
            _body.setFrame(job);
            _movie.visible = false;
         }
      }
      
      public function set job(param1:int) : void
      {
         _job = param1;
         _bg.setFrame(_job);
         _jobType.setFrame(_job);
         creatEff();
      }
      
      public function get job() : int
      {
         return _job;
      }
      
      public function set sex(param1:int) : void
      {
         _sex = param1;
         creatEff();
      }
      
      public function get sex() : int
      {
         return _sex;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_movie)
         {
            _movie.visible = _selected;
         }
         if(_scaleBg)
         {
            _scaleBg.visible = _selected;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_scaleBg);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_body);
         _body = null;
         ObjectUtils.disposeObject(_jobType);
         _jobType = null;
         ObjectUtils.disposeViolentMc(_movie);
         _movie = null;
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         super.dispose();
      }
   }
}

